---
title: Getting Started
layout: normal
children:
- { path: quickstart/install.md }
---

This guide will walk you through deploying an application to a public cloud.

We will be deploying an example 3-tier web application written in YAML blueprint, following the [camp specification](https://www.oasis-open.org/committees/camp/): 

{% highlight yaml %}
{% readj _my-web-cluster.yaml %}
{% endhighlight %}

using the following steps:

* Step 1: [Set up](#set-up)
* Step 3: [Deploy your first blueprint](#deploy-first-blueprint)
* Step 4: [Monitoring and Managing Applications](#monitoring-managing-applications)
* Step 4: [Set up policies and catalogs](#policies-and-catalogs)

## <a id="set-up"></a>Set up the environment

Follow the [installation guide](install.html).

## <a id="deploy-first-blueprint"></a>Deploy your first blueprint

There are several ways to deploy a YAML blueprint (including specifying the blueprint on the command line or submitting it via the REST API).

For now, we will simply copy-and-paste the raw YAML blueprint into the web console.
First of all, start Brooklyn:

{% highlight bash %}
$ brooklyn launch
{% endhighlight %}

Open the web console ([127.0.0.1:8081](http://127.0.0.1:8081)). As Brooklyn is not currently managing any applications the 'Create Application' dialog opens automatically. Select the YAML tab.

![Brooklyn web console, showing the YAML tab of the Add Application dialog.](/quickstart/images/add-application-modal-yaml.png)

### Chose your Location

Edit the 'location' parameter in the YAML template (repeated below) to use the location you configured.

For example, replace:
{% highlight yaml %}
location: location
{% endhighlight %}

with (one of):
{% highlight yaml %}
location: aws-ec2:us-east-1
location: rackspace-cloudservers-us:ORD
location: google-compute-engine:europe-west1-a
{% endhighlight %}

If you would rather test Brooklyn on localhost, follow [these instructions]({{ site.data.brooklyn.url.userguide }}/use/guide/locations/) to ensure that your Brooklyn can access your machine and then specify:
{% highlight yaml %}
location: localhost
{% endhighlight %}



Paste the modified YAML into the dialog and click 'Finish'.

**My Web Cluster Blueprint**

{% highlight yaml %}
{% readj _my-web-cluster.yaml %}
{% endhighlight %}

The dialog will close and Brooklyn will begin deploying your application.

Your application will be shown as 'Starting' on the web console's front page.

![My Web Cluster is STARTING.](/quickstart/images/my-web-cluster-starting.png)

## <a id="monitoring-managing-applications"></a> Monitoring and Managing Applications

Click on the application name, or open the Applications tab.

We can explore the management hierarchy of the application, which will show us the entities it is composed of.

 * My Web Cluster (A `BasicApplication`)
     * My DB (A `MySqlNode`)
     * My Web (A `ControlledDynamicWebAppCluster`)
        * Cluster of JBoss7 Servers (A `DynamicWebAppCluster`)
        * NginxController (An `NginxController`)



Clicking on the 'My Web' entity will show the Summary tab. Here we can see if the cluster is ready to serve and, when ready, grab the web address for the front of the loadbalancer.

![Exploring My Web.](/quickstart/images/my-web.png)


The Activity tab allows us to drill down into what activities each entity is currently doing or has recently done. It is possible to drill down to all child tasks, and view the commands issued, and any errors or warnings that occured.

Drill into the 'My DB' start operation. Working down through  'Start (processes)', then 'launch', we can discover the ssh command used including the stdin, stdout and stderr.

[![My DB Activities.](images/my-db-activities.png)](/quickstart/images/my-db-activities-large.png)


## Stopping the Application

To stop an application, select the application in the tree view (the top/root entity), click on the Effectors tab, and invoke the 'Stop' effector. This will cleanly shutdown all components in the application and return any cloud machines that were being used.

[![My DB Activities.](images/my-web-cluster-stop-confirm.png)](/quickstart/images/my-web-cluster-stop-confirm-large.png)


## <a id="policies-and-catalogs"></a> Set up Policies and catalogs

So far we have touched on Brooklyn's ability to *deploy* an application blueprint to a cloud provider, but this a very small part of Brooklyn's capabilities!

Brooklyn's real power is in using Policies to automatically *manage* applications. There is also the (very useful) ability to store a catalog of application blueprints, ready to go.

[Policies and Catalogs](policies-and-catalogs.html)
