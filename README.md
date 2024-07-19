# Container Image base

This commit is the base commit for setting up new Container image build processes. You'd need to adjust `.github/workflows/build_imag.yaml` file and adjust the values starting by `___foo` and create a branch named `build` where the only change is to empty the JSON dictionary in `built_versions.json`.
