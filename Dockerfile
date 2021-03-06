FROM mcr.microsoft.com/quantum/iqsharp-base:0.12.20082513

ENV IQSHARP_HOSTING_ENV=CHP_DOCKER
USER root
RUN pip install RISE

# Make sure the contents of our repo are in ${HOME}.
# These steps are required for use on mybinder.org.
COPY . ${HOME}
RUN chown -R ${USER} ${HOME}

# Drop back down to user permissions for things that don't need it.
USER ${USER}

RUN mkdir ${HOME}/local-nuget && \
    dotnet nuget add source ${HOME}/local-nuget -n "Chp" && \
    dotnet pack ${HOME}/src/ChpSimulator.csproj && \
    cp ${HOME}/src/bin/Debug/*.nupkg ${HOME}/local-nuget && \
    pip install numpy matplotlib

