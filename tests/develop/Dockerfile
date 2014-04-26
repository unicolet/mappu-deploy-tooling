# Mappu

FROM       saltstack/centos-6-minimal 
MAINTAINER Umberto Nicoletti

# Install mappu and its dependencies. Note that we inform Salt that we
# are running under docker. This is required to avoid issues during installation
# due to missing upstart and firewall
RUN echo "NETWORKING=yes" > /etc/sysconfig/network && \
    test -f /etc/yum.repos.d/epel.repo || /bin/rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && \
    /usr/bin/yum -y install git && \
    echo "Installing salt/develop" && \
    curl -L https://github.com/saltstack/salt-bootstrap/raw/stable/bootstrap-salt.sh | sed "s/__check_services_upstart salt-\$fname || return 1/__check_services_upstart salt-\$fname || return 0/" | sh -s -- -X git develop && \
    cd / && \
    echo "Cloning deploy scripts repo" && \
    /usr/bin/git clone https://github.com/unicolet/mappu-deploy-tooling.git && \
    echo "Linking minion.conf" && \
    /bin/cp -f /mappu-deploy-tooling/salt/minion.conf /etc/salt/minion && \
    echo "Linking states" && \
    /bin/ln -s /mappu-deploy-tooling/salt/states/salt /srv/salt && \
    echo "Linking pillar" && \
    /bin/ln -s /mappu-deploy-tooling/salt/states/pillar /srv/pillar && \
    echo "Highstate" && \
    salt-call state.highstate pillar="{'mappu_version':'unstable','docker':True}"

