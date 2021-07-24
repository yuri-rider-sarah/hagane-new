TARGET = hagane
HAGANE = ./_hagane
CXX = clang++
CXXFLAGS = -Wall
HGN_FLAGS =

HGN_SRC = std.hgn vector.hgn error.hgn char_types.hgn lexer.hgn parser.hgn expr.hgn infer_prop.hgn infer_fin.hgn codegen.hgn main.hgn

HEADERS = $(filter-out char_types_data.h,$(wildcard *.h))
LIBS = stdc++ LLVM-12
OBJECTS = $(patsubst %.cpp,%.o,$(wildcard *.cpp))

$(TARGET): $(HGN_SRC) $(OBJECTS)
	$(HAGANE) $(HGN_FLAGS) $(HGN_SRC) $(addprefix -L,$(OBJECTS)) $(addprefix -o,$@) $(addprefix -L-l,$(LIBS))

char_types_data.h: char_types_gen.py
	./char_types_gen.py

char_types.o: char_types.cpp char_types_data.h
	$(CXX) -c $(CXXFLAGS) $< -o $@

%.o: %.cpp $(HEADERS)
	$(CXX) -c $(CXXFLAGS) $< -o $@
