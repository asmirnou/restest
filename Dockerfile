FROM dockcross/linux-x64

EXPOSE 8080

COPY . ./restest

RUN mkdir restest/build
WORKDIR restest/build
RUN cmake ..
RUN make test
RUN make

CMD ["/work/restest/build/restest"]