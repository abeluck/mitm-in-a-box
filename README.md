# mitm-in-a-box

> A vagrant + ansible setup for running mitm'ing your vms.

## What now?

This repo will create an internal network and configure a `mitm-server` vm
which acts as the gateway router (DHCP + NAT) for all machines on that internal
network. This `mitm-server` will also transparently mitm all HTTP(S)
traffic that passes through it with [mitmproxy](https://mitmproxy.org/)

It also provides you with a vagrant + ansible quickstart for configuring your
own vms to run inside the network.

## Dependencies

You need this software on your host box:

* vagrant
* virtualbox
* ansible >= 2.4
* mitmproxy >= 4.x

## Quickstart

1. Install `mitmproxy` > 4.x.  - we only need it for generating the ca cert,
   all actually mitming will happen in a vm.  Don't use apt. I recommend
   downloading the binaries directly from: https://mitmproxy.org/

2. Generate the ca cert

    ```
    make
    ```

3. Setup the `mitm-server`

    ```
    cd mitm-server
    vagrant up
    ```

    At this point you have an internal virtualbox network (named `mitmnet`)
    running. The `mitm-server` has ip address `10.0.3.3` on this network, and is
    serving DHCP and NATing for clients.

4. Setup a test client

    ```
    cd ../mitm-client
    vagrant up
    ```

    Now you have the vm `mitm-client` with an ip address in the `10.0.3.50 - 250`
    range which is using `mitm-server` as its default gateway. It has the
    mitmproxy ca certs installed so it will trust our non-valid ca cert.

5. Test it out

    **Console 1**

    ```
    cd mitm-client
    vagrant ssh
    curl https://yahoo.com # request completes succesfully
    ```

    **Console 2**

    ```
    cd mitm-server
    vagrant ssh
    mitmproxy -r mitmdump.log --showhost --no-server # view the stored log
    ```

## Credits

This fine repo you're browsin' was cooked up by Abel Luck in the fall of 2018.

props to those who blazed the trail 🤘 🔥:

* [Setting up Transparent Proxying VMs for mitmproxy](https://nickcharlton.net/posts/transparent-proxy-virtual-machines-mitmproxy.html) by Nick Charlton
* [MITM-VM](https://github.com/praetorian-inc/mitm-vm) by Kelby Ludwig


