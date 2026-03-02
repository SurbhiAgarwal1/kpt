## Issue #4347: EPIC - Support Independent Subpackage Creation, Clone and Update

### Problem Statement

Currently, kpt treats subpackages as **dependent** on their parent package. This means:
- Subpackages are always fetched/updated as part of the parent package
- You cannot independently create, clone, or update a subpackage
- Subpackages are tightly coupled to the parent package lifecycle

The EPIC requests support for **independent subpackages** that can:
1. Be initiated independently within a package
2. Be cloned independently into packages
3. Be upgraded independently without affecting the parent

### Current Implementation Analysis

From analyzing the codebase:

**1. Kptfile Structure** (`pkg/api/kptfile/v1/types.go`):
```go
type Subpackage struct {
    LocalDir string      // Subdirectory name
    Upstream *Upstream   // Remote reference (if remote subpackage)
}
```

**2. Current Fetch Logic** (`internal/util/get/get.go`):
- `fetchPackages()` uses a stack to traverse all subpackages
- Fetches parent first, then recursively fetches all subpackages
- All subpackages are fetched together as a unit

**3. Current Update Logic** (`commands/pkg/update/cmdupdate.go`):
- Updates operate on the entire package hierarchy
- No way to update just a subpackage

### What Needs to Change

#### 1. **Subpackage Initiation** (`kpt pkg init`)
Allow creating a new subpackage within an existing package:
```bash
# Current: Can only init at root level
kpt pkg init my-package

# Needed: Init a subpackage independently
kpt pkg init parent-pkg/subpkg --subpackage
```

**Implementation:**
- Modify `commands/pkg/init/cmdinit.go` to support `--subpackage` flag
- Update parent Kptfile to register the new subpackage
- Create Kptfile in subpackage directory

#### 2. **Independent Subpackage Cloning** (`kpt pkg get`)
Allow fetching a specific subpackage without the parent:
```bash
# Current: Fetches entire package hierarchy
kpt pkg get https://github.com/org/repo/parent-pkg

# Needed: Fetch only a specific subpackage
kpt pkg get https://github.com/org/repo/parent-pkg/subpkg --independent
```

**Implementation:**
- Add `--independent` flag to `commands/pkg/get/cmdget.go`
- Modify `internal/util/get/get.go` to skip parent package fetch
- Fetch only the specified subpackage path

#### 3. **Independent Subpackage Update** (`kpt pkg update`)
Allow updating a subpackage without updating the parent:
```bash
# Current: Updates entire package hierarchy
kpt pkg update parent-pkg

# Needed: Update only a specific subpackage
kpt pkg update parent-pkg/subpkg --independent
```

**Implementation:**
- Add `--independent` flag to `commands/pkg/update/cmdupdate.go`
- Modify `internal/util/update/update.go` to update only target subpackage
- Skip parent package update logic

### Dependencies

This EPIC depends on **Issue #4271** (Align kpt pipeline execution in kpt and Porch):
- Porch (Package Orchestration) needs to support the same independent subpackage behavior
- Pipeline execution must work consistently across kpt CLI and Porch
- Kptfile structure changes must be compatible with Porch

### Implementation Phases

**Phase 1: Design & Specification**
- [ ] Define Kptfile schema changes (if any)
- [ ] Design CLI interface and flags
- [ ] Document behavior and edge cases
- [ ] Get maintainer approval

**Phase 2: Independent Init**
- [ ] Add `--subpackage` flag to `kpt pkg init`
- [ ] Implement subpackage registration in parent Kptfile
- [ ] Add tests
- [ ] Update documentation

**Phase 3: Independent Clone**
- [ ] Add `--independent` flag to `kpt pkg get`
- [ ] Modify fetch logic to support subpackage-only fetch
- [ ] Handle upstream references correctly
- [ ] Add tests
- [ ] Update documentation

**Phase 4: Independent Update**
- [ ] Add `--independent` flag to `kpt pkg update`
- [ ] Modify update logic to support subpackage-only update
- [ ] Handle merge strategies correctly
- [ ] Add tests
- [ ] Update documentation

**Phase 5: Porch Integration**
- [ ] Coordinate with Porch team
- [ ] Ensure pipeline execution consistency
- [ ] Integration testing
- [ ] Update Nephio project tracking

### Complexity Assessment

**Difficulty: HARD/EPIC**

**Reasons:**
1. **Architectural Change**: Requires rethinking package hierarchy model
2. **Multiple Commands**: Affects `init`, `get`, and `update` commands
3. **Backward Compatibility**: Must not break existing workflows
4. **Cross-Project Coordination**: Depends on Porch alignment (#4271)
5. **Testing Complexity**: Many edge cases and scenarios
6. **Documentation**: Extensive docs updates needed

**Estimated Effort:** 3-4 weeks for experienced contributor

### Risks & Considerations

1. **Breaking Changes**: Could affect existing package structures
2. **Merge Conflicts**: Independent updates may cause conflicts
3. **Dependency Management**: Subpackages may have interdependencies
4. **Porch Compatibility**: Must stay in sync with Porch implementation
5. **User Confusion**: Need clear documentation on when to use independent mode

### Recommended Approach for New Contributors

**DO NOT START** without:
1. Maintainer approval and design review
2. Clear specification document
3. Understanding of Porch architecture
4. Coordination with Nephio project

**INSTEAD:**
1. Post questions on the issue asking for current status
2. Ask if design doc exists or needs to be created
3. Offer to help with specific sub-tasks once design is approved
4. Start with smaller, related issues to build context

### Questions for Maintainers

1. Is there an existing design document for this feature?
2. What is the current status of issue #4271 (Porch alignment)?
3. Should independent subpackages be opt-in or default behavior?
4. Are there any Kptfile schema changes planned?
5. What is the priority/timeline for this EPIC?
6. Can this be broken into smaller, independent issues?

