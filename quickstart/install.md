---
layout: normal
title: Install Apache Brooklyn&reg;
permalink: /quickstart/install/
---
1. [Setup the prerequisites](#prerequisites)
1. [Download Brooklyn](#download)
1. [Configuring brooklyn.properties](#configuring)
1. [Confirm installation](#confirm)

## tl;dr
There is a simple bash script available to help with the installation process.

If you want to install Apache Brooklyn on a server (or you *nix!) you can run:
{% highlight bash %}
$ curl -o brooklyn-install.sh https://raw.githubusercontent.com/andreaturli/incubator-brooklyn/feature/brooklyn-install-script/brooklyn-install.sh
$ chmod +x ./brooklyn-install.sh
$ ./brooklyn-install.sh -s -r <your-server-ip>
{% endhighlight %}

Note: the script assumes you have passwordless ssh access to your server.

## <a id="prerequisites"></a>Install prerequisites

Before installing Apache Brooklyn, you will need the following:

* Java JRE or SDK installed (version 6 or later)

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

## <a id="configuring"></a>Configuring brooklyn.properties
Before we really use Brooklyn, we need to create a `brooklyn.properties` file based on a basic template that you will need to edit.

{% highlight bash %}
$ mkdir ~/.brooklyn
$ cd ~/.brooklyn
$ wget https://brooklyn.incubator.apache.org/quickstart/brooklyn.properties
$ chmod 600 ~/.brooklyn/brooklyn.properties
{% endhighlight %}
Open `~/.brooklyn/brooklyn.properties` with your favourite text editor and add your credentials for any of the cloud providers supported by Apache Brooklyn.

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
