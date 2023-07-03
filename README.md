## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

    helm repo add runbear https://runbear-io.github.io/helm-charts

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
runbear` to see the charts.

Prior to installing the chart, you must create a worker and obtain an API secret.
Navigate to [worker setup page](https://app.runbear.io/workers) to create a worker.

To install the runbear-worker chart:

    helm install runbear-worker runbear/runbear-worker --set runbear.apiSecret=WORKER_API_SECRET

To uninstall the chart:

    helm delete runbear-worker
