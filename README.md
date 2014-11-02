dockerComp
==========

**Introduction**

For the purpose of Distributing computing, scientists across the world have been 
mostly using pre-configured VM images to let the client volunteer in contributing 
towards micro-processing tasks  that involve processing of raw data received in 
chunks over the network. 

But, since the introduction of Docker, life has changed and so have the performance 
benchmarks. We propose an system that uses the benefits of Docker to hopefully perform 
far better than the currently achieved milestones through VMs. The VMs have a huge 
overhead of starting up, as compared to Docker containers. Moreover, we don't even need 
to explain the difference between running more than one VM on a HostOS compared to 
running multiple docker containers on that same machine! See the point? :)

Ref: 
     - http://www.rightscale.com/blog/sites/default/files/docker-containers-vms.png 
     - http://en.wikipedia.org/wiki/Docker_%28software%29#cite_ref-3

So, just to give you a context of this whole project, take a look at this project called
[CernVM](http://cernvm.cern.ch/portal/). This is a really awesome project, developed to
help collect CERN's LHC data and perform data analysis on a volunteer's computer or even on
commercial clouds. Just imagine if the whole process of using VM was dockerized!    
 
**Features**

- Can be used for:
      - Image Processing
      - General Data Analysis
      - Scientific Computing
      - CrowdSourcing projects.

**Workflow**

1. Server

   - Dashboard to Manage:
     - No. of Clients (and # of containers per client)
     - Resources allocated to the containers
   
   - Master app  that manages data sent to each client and checks for integrity.

2. Client

   - Installation of Docker
   - Starting Containers
   - Installation of Application inside the Container
   - Connection Establishment with the Server.
   - Scripts for the computation
   - Error Reporting

**References**

1. https://github.com/cernvm
2. http://en.wikipedia.org/wiki/List_of_distributed_computing_projects
3. https://github.com/cernvm
4. http://www.psc.edu/science/
5. http://pybossa.com/
6. https://okfn.org/press/releases/crowdcrafting-putting-citizens-control-citizen-science/
7. http://www.mediaagility.com/2014/docker-the-next-big-thing-on-cloud/
8. http://cernvm.cern.ch/portal/

