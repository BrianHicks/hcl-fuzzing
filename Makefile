clean:
	rm -rf test-fixtures/{crashers,corpus,suppressions}

fuzzy-fuzz.zip: fuzz.go
	go-fuzz-build github.com/BrianHicks/fuzz-hcl

test: fuzzy-fuzz.zip
	go-fuzz -bin=./fuzzy-fuzz.zip -workdir=./test-fixtures -procs=8
