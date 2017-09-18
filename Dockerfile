FROM dockcross/linux-x64

EXPOSE 8080

COPY . ./restest

RUN mkdir restest/build
WORKDIR restest/build
RUN cmake ..
RUN make
RUN make test

CMD ["/work/restest/build/restest"]