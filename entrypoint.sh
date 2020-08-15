#!/bin/sh -l

if [ "$GITHUB_EVENT_NAME" = "issue_comment" ]; then
    author=$(cat $GITHUB_EVENT_PATH | jq -r .comment.user.login)
    comment=$(cat $GITHUB_EVENT_PATH | jq -r .comment.body)
    comments_url=$(cat $GITHUB_EVENT_PATH | jq -r .issue.comments_url)
fi

if [ "$GITHUB_EVENT_NAME" = "issues" ]; then
    author=$(cat $GITHUB_EVENT_PATH | jq -r .issue.user.login)
    comment=$(cat $GITHUB_EVENT_PATH | jq -r .issue.body)]
    comments_url=$(cat $GITHUB_EVENT_PATH | jq -r .issue.comments_url)
fi

if [ "$GITHUB_EVENT_NAME" = "pull_request_review_comment" ]; then
    author=$(cat $GITHUB_EVENT_PATH | jq -r .comment.user.login)
    comment=$(cat $GITHUB_EVENT_PATH | jq -r .comment.body)
    comments_url=$(cat $GITHUB_EVENT_PATH | jq -r .comment.url)"/replies"
fi

# echo $author
# echo $comment
# echo $comments_url

profanity=$(python3 /check.py "$comment")

if [ "$profanity" = "1" ]; then
    echo "$::set-output name=RESULT::User said something bad"

    curl --include --verbose --fail \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    --request POST --data '{"body": "@'$author' Please mind your language."}' \
    $comments_url
else
    echo "$::set-output name=RESULT::User said something good"
fi
