---
layout: normal
title: Install Apache Brooklyn&reg;
---
1. [Set up the prerequisites](#prerequisites)
1. [Download Brooklyn](#download)
1. [Configuring brooklyn.properties](#configuring-properties)
1. [Configuring catalog.xml](#configuring-catalog)
1. [Confirm installation](#confirm)

## tl;dr
There is a simple bash script available to help with the installation process. 

#### Script prerequisites
The script assumes that the server is a recent RHEL/CentOS 6.x Linux or Ubuntu 12.04 installation, preferably with the latest Oracle Java 1.6.0 JRE installed, but other Linux variants have been tested successfully, and the script will install Java and other required packages if they are not present. You must have root access over [passwordless SSH](/learnmore/passwordless-ssh.html) to install brooklyn, but the service runs as an ordinary user once installed. To manage the brooklyn service you must also be able to connect to port 8081 remotely.

Once this prerequisites are satisfied, you can run:
{% highlight bash %}
$ curl -o brooklyn-install.sh http://git.io/GzkOKQ
$ chmod +x ./brooklyn-install.sh
$ ./brooklyn-install.sh -s -r <your-server-ip>
{% endhighlight %}

## <a id="prerequisites"></a>Set up the prerequisites

Before installing Apache Brooklyn, you will need to configure the host as follows. 

* install Java JRE or SDK (version 6 or later)
* install [SSH key](/learnmore/ssh-key.html), if not available.
* enable [passwordless ssh login](/learnmore/passwordless-ssh.html).
* create a `~/.brooklyn` directory on the host with `$ mkdir ~/.brooklyn`
* Check your iptables service, and if enabled, make sure that it accepts all incoming connections to 8443+ ports.
* [optional] Increase [linux kernel entropy](/learnmore/increase-entropy.html) for faster ssh connections.

## <a id="download"></a>Download Brooklyn

Download the [Brooklyn distribution]({{ site.data.brooklyn.url.dist.tgz }}) and expand it to your home directory ( `~/` ), or in a location of your choice. 
(Other [download options]({{site.url}}/download.html) are available.)

{% if brooklyn_version contains 'SNAPSHOT' %}
Expand the `tar.gz` archive (note: as this is a -SNAPSHOT version, your filename will be slightly different):
{% else %}
Expand the `tar.gz` archive:
{% endif %}

{% if brooklyn_version contains 'SNAPSHOT' %}
{% highlight bash %}
$ tar -zxf brooklyn-dist-{{ site.data.brooklyn.version }}-timestamp-dist.tar.gz
{% endhighlight %}
{% else %}
{% highlight bash %}
$ tar -zxf brooklyn-dist-{{ site.data.brooklyn.version }}-dist.tar.gz
{% endhighlight %}
{% endif %}

This will create a `brooklyn-{{ site.data.brooklyn.version }}` folder.

Let's setup some paths for easy commands.

{% highlight bash %}
$ cd brooklyn-{{ site.data.brooklyn.version }}
$ BROOKLYN_DIR="$(pwd)"
$ export PATH=$PATH:$BROOKLYN_DIR/bin/
{% endhighlight %}

## <a id="configuring-properties"></a>Configuring brooklyn.properties
Brooklyn deploys applications to Locations. *Locations* can be clouds, machines with fixed IPs or localhost (for testing).

By default Brooklyn loads configuration parameters (including credentials for any cloud accounts) from 

`~/.brooklyn/brooklyn.properties` 

The `brooklyn.properties` is the main configuration file for deployment locations. Contains the connection details and credentials for all public or on-premises cloud providers, as well as controlling some application startup and security options.

Create a `.brooklyn` folder in your home directory and download the template [brooklyn.properties](brooklyn.properties) to that folder.

{% highlight bash %}
$ mkdir -p ~/.brooklyn
$ curl -o ~/.brooklyn/brooklyn.properties http://brooklyncentral.github.io/use/guide/quickstart/brooklyn.properties
$ chmod 600 ~/.brooklyn/brooklyn.properties
######################################################################## 
100.0%
{% endhighlight %}

You may need to edit `~/.brooklyn/brooklyn.properties` to ensure that brooklyn can access cloud locations for application deployment.

## <a id="configuring-catalog"></a>Configuring catalog.xml
By default Brooklyn loads the catalog of available application components and services from 
`~/.brooklyn/catalog.xml`. 

{% highlight bash %}
$ curl -o ~/.brooklyn/catalog.xml \
http://brooklyncentral.github.io/use/guide/quickstart/catalog.xml
######################################################################## 
100.0%
{% endhighlight %}

The `catalog.xml` is the application blueprint catalog. The above example file contains some blueprints which will be automatically downloaded from the web if you run them.

You may need to edit `~/.brooklyn/catalog.xml` to update links to any resources for download.

## <a id="confirm"></a>Confirm installation
We can do a quick test drive by launching Brooklyn:

{% highlight bash %}
$ brooklyn launch
{% endhighlight %}

Brooklyn will output the address of the management interface:

{% highlight bash %}
INFO  Starting brooklyn web-console on loopback interface because no security config is set

INFO  Started Brooklyn console at http://127.0.0.1:8081/, running classpath://brooklyn.war and []
{% endhighlight %}

Stop Brooklyn with ctrl-c.
