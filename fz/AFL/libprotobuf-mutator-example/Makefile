FUZZER=test_fuzzer

PROTO=test
PROTO_FILE=$(PROTO).proto
PB_SOURCE=$(PROTO).pb.cc
PB_OBJECT=$(PROTO).pb.cc.o
PB_ARCHIVE=$(PROTO).pb.a

LIBPROTOBUF_MUTATOR_PATH=/home/fuzzing/tools/libprotobuf-mutator

PROTOC=$(LIBPROTOBUF_MUTATOR_PATH)/build/external.protobuf/bin/protoc

INC=-isystem $(LIBPROTOBUF_MUTATOR_PATH)/build/external.protobuf/include \
	-I$(LIBPROTOBUF_MUTATOR_PATH)

LIBS=$(LIBPROTOBUF_MUTATOR_PATH)/build/src/libfuzzer/libprotobuf-mutator-libfuzzer.a \
	$(LIBPROTOBUF_MUTATOR_PATH)/build/src/libprotobuf-mutator.a \
	$(LIBPROTOBUF_MUTATOR_PATH)/build/external.protobuf/lib/libprotobuf.a \
	-lpthread


all: clean custom_mutator fuzzer serializer run

run:
	AFL_DISABLE_TRIM=1 \
	AFL_CUSTOM_MUTATOR_ONLY=1 \
	AFL_CUSTOM_MUTATOR_LIBRARY=`pwd`/libcustom_mutator.so \
	afl-fuzz -i ./in -o ./out -- ./$(FUZZER)

fuzzer:
	afl-gcc main.c -o $(FUZZER)

custom_mutator: proto.a
	clang++ -g -shared -fPIC $(INC) custom_mutator.cc -o libcustom_mutator.so $(LIBS) $(PB_ARCHIVE)

proto.a: 
	$(PROTOC) --cpp_out=. $(PROTO_FILE) && \
	clang++ $(INC) -fPIC $(PB_SOURCE) -o $(PB_OBJECT) -c && \
	ar qc $(PB_ARCHIVE) $(PB_OBJECT) && \
	ranlib $(PB_ARCHIVE)

serializer:
	clang++ $(INC) serializer.cc -o serializer $(PB_ARCHIVE) $(LIBS)
	./serializer

clean:
	rm -f $(PB_SOURCE) $(PB_OBJECT) $(PB_ARCHIVE)