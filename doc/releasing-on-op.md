# Releasing Stepbet Game Service

For `api.stepbet.com` and `dev.stepbet.com` we use giftlow for creating releases.

We create the release manually with the steps:

1. Init release 
```
git flow init -d
git flow release start 1.0.0
```
2. Add entries into CHANGELOG.md
```
gedit CHANGELOG.md
```
3. Commit and release (or commit from git desktop)
```
git commit -a -m 'Bump version to 1.0.0'
git push
```
4. Finish the release:
```
git flow release finish
```	
Git flow will prompt three times
  First prompt, leave default merge message:
```
merge branch 'release/1.0.0'
```
  Second prompt, edit tag to contain version at top and changes 
```
v1.0.0
- [LSQD-279] Look Into Garmin API - Request header correction
- [LSQD-146] Deleted Superuser Posts in StepBet remain posted in game.
- [LSQD-105] Archive old rows from user_daily_steps into a separate table
    #
    # Write a message for tag:
    #   v1.0.0
    # Lines starting with '#' will be ignored.
```
  Third prompt, leave default merge message 
```
Merge tag 'v1.0.0' into develop
```
5. Push everything, including, develop and tags
```
git push && git checkout master && git push && git push --tags
```
6. Check that you see three commits on develop. You should see the following three commits
```
Merge tag 'v1.0.0' into develop 
Merge branch 'release/v1.0.0'
Bump version to 1.0.0
```