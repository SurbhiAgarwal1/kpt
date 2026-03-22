Thanks for looking into this! 

I see you found a potential bug in the set-namespace function. That makes sense - I was confused because the Docker CI was showing `:latest` resolving to v0.2.0 instead of v0.4.5, which explained why the tests were failing with different output.

I'll wait for the review/response on your bug fix before proceeding. Once that's sorted out, I can split this PR into two parts like you suggested - one for `fn-eval` and one for `fn-render`.

Also noted about the stray file changes in documentation/static/images/lifecycle - I'll make sure to clean those up.

Should I hold off on making any changes until we hear back about the bug fix?
