all: spock

rebuild: clean all

spock: spock.pl parser.pl move_maker.pl board_analyser.pl
	swipl -q -t main -O -o $@ -c $<

clean:
	rm -f spock

submit:
	rm -rf ra115966 ra115966.zip
	mkdir ra115966
	cp *.pl makefile nome_do_jogador ra115966
	zip -9r ra115966.zip ra115966

.PHONY: all clean rebuild
