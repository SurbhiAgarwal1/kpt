Hi @liamfallon,

I've updated `internal/kptops/functions.go` to v0.4.5 as you suggested, but the tests are still failing with a version mismatch:

```
Expected: set-namespace:v0.4.5
Got: set-namespace:v2.0
```

It seems the runtime is resolving to v2.0 even though we specified v0.4.5. 

Could you help clarify:
1. Should I update all the test files to expect v2.0 instead?
2. Or is there a configuration issue causing the version resolution to v2.0?

The tests passed for you locally with v0.4.5, so I'm wondering if there's a difference in the CI environment.

Thanks!
