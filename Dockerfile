FROM sonatype/nexus3:3.13.0
USER root
RUN yum update --assumeyes --skip-broken && \
    yum install --assumeyes git curl net-tools wget sudo

WORKDIR /build
RUN git clone https://github.com/sonatype-nexus-community/nexus-blobstore-google-cloud.git . && \
    git clone https://github.com/yogeshkd786/devop_gcp_challenge.git && \
    wget https://www-us.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz -P /tmp && \
    chmod 755 /tmp/apache-maven-3.6.0-bin.tar.gz && \
    tar -xvf /tmp/apache-maven-3.6.0-bin.tar.gz -C . && \
    chown -R nexus:nexus /build && \
    chown -R nexus:nexus /opt/sonatype


USER nexus

#COPY dark-star-222506-c3f36ccf19a9.json /build/devop_gcp_challenge/

ENV M2_HOME=/build/apache-maven-3.6.0 \
    MAVEN_HOME=/build/apache-maven-3.6.0 \
    PATH=/build/apache-maven-3.6.0/bin/:$PATH

RUN mvn clean package -DskipTests

#ENV GOOGLE_APPLICATION_CREDENTIALS=/build/devop_gcp_challenge/dark-star-222506-c3f36ccf19a9.json
RUN chmod +x install-plugin.sh && \
    ./install-plugin.sh /opt/sonatype/nexus/ && \
    scp -r /build/devop_gcp_challenge/nexus-core-feature-3.13.0-01-features.xml /opt/sonatype/nexus/system/org/sonatype/nexus/assemblies/nexus-core-feature/3.13.0-01/




