## Description
Describe what changes you are making in this pull request. If you are changing behaviour explain what the original behaviour was and how it has been changed.

## Related issues
Reference the issue that this pull request addresses, there needs to be at least one issue. Use keywords to reference the issue(Fixes, Resolves etc).

## Checklist
- [ ] I read the contributing guidelines
- [ ] I updated the relevant documentations(Or filed a new issue for updating documentation)
- [ ] I agree to follow up on all review comments and bugs that are caused because of this pull request in a timely manner
- [ ] The issues referenced in this pull request are assigned to me, or I have explicitly stated in those issues that I will be working on them(to avoid overlap of work)
- [ ] I have run the project on all supported platforms and verified that it works correctly

## Testing
- [ ] All current tests(if any) still pass after making these changes
- [ ] I have changed existing tests to accomodate for these changes
  - [ ] All new features/changes to existing features have been added to test cases

## Release checks
- [ ] No existing test cases were changed and no test cases failed(this is not a breaking change)
- [ ] Yes existing test cases were changed or failed(this is a breaking change)

## Analysis output
Please provide the output of the `flutter analyze` command after you made changes. This is to ensure that all warnings from flutter static analyses has been solved, failure in doing so will lead in us asking you to solve them first.
