#!/usr/bin/env sh

: <<'EOF'
# push-release
Create a tag and release using 

## Requirements
`go install github.com/github-release/github-release@v0.10.0`

## Required ENV variables
GITHUB_API: None to use GitHub, set to use other
GITHUB_TOKEN: Your API token (full repo permissions)

## Optional ENV variables
GITHUB_AUTH_USER: User that owns token, uses user/project if none
TARGET: Branch or SHA to use when creating tag

## Arguements
VERSION: Required format: X.X.X, where X is int
NAME: Name of release that will be created
DESCRIPTION: What will constitute description of release
GLOBS: Sequence of file globs to upload in to release

### Simple use
`./push-release.sh 0.1.21 "release" "not a description"`

### Upload files with release
`./push-release.sh 0.1.21 "release" "not a description" bin/* dist/thing.exe`
EOF


set -x

# GITHUB_API to set URL
# GITHUB_TOKEN to set token
# GITHUB_AUTH_USER to set auth user (optional)
export GITHUB_USER=$(dirname $(git remote get-url origin | sed 's/.*://') )
export GITHUB_REPO=$(basename $(git remote get-url origin) | sed -e 's/.git$//')

# Target branch or SHA
TARGET="${TARGET:-master}"

# Required format: X.X.X, where X is int
VERSION=$1
shift

# Version equivalent used by GitHub
GIT_TAG="v${VERSION}"

# Name of release that will be created
NAME=$1
shift

# What will constitute description of release
DESCRIPTION=$1
shift

# Sequence of file globs to upload in to release
GLOBS="$@"

set +x


echo 'Parse version'
echo "$VERSION" \
    | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' \
    || { echo "Version parse failed: ${VERSION}";  exit 1; }


echo 'Ensure clean git stage'
[[ -z $(git status --porcelain) ]] \
    || { echo 'Git stage was not clean'; exit 2; }


echo 'Ensure tag does not exist already'
[[ -z $(git tag -l "$GIT_TAG") ]] \
    || { echo "Tag already existed: ${GIT_TAG}"; exit 3; }


echo 'Set the version and create the commit'
poetry version "$VERSION" \
    && git add . \
    && git commit -m "Bump version to ${GIT_TAG}" \
    && git tag "$GIT_TAG" \
    || { echo 'Could not bump version locally'; exit 4; }


echo 'Update origin with new tag'
git push \
    && git push origin "$GIT_TAG" \
    || { echo 'Failed to update origin'; exit 5; }


echo 'Ensure release is not created already'
! github-release info \
        --tag "$GIT_TAG" \
    || { echo 'Release already created'; exit 6; }


echo 'Create release'
github-release release \
        --target "$TARGET" \
        --tag "$GIT_TAG" \
        --name "$NAME" \
        --description "$DESCRIPTION" \
    || { echo 'Failed to create release'; exit 7; }


echo 'Upload files'
for glob in $GLOBS; do
    for file in $(find $glob); do
        echo "Upload: ${file}"
        github-release upload \
            --tag "$GIT_TAG" \
            --name "$(basename $file)" \
            --file "$file" \
        || echo "Failed to upload: ${file}"
    done
done

