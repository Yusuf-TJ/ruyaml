
UTILNAME:=yaml
PKGNAME:=ruamel.yaml
VERSION:=$(shell python setup.py --version)
REGEN:=/home/bin/ruamel_util_new util --published --command YAML --skip-hg

include ~/.config/ruamel_util_new/Makefile.inc

gen_win_whl:
	@python make_win_whl.py dist/$(PKGNAME)-$(VERSION)-*-none-any.whl

clean:	clean_common
	find . -name "*py.class" -exec rm {} +

cython:	ext/_yaml.c

ext/_yaml.c:	ext/_yaml.pyx
	cd ext; cython _yaml.pyx
	
ls-l:
	ls -l dist/*$(VERSION)*

appveyor:
	ssh -x -a appveyor@localhost "cd $$PWD; hg push ssh://hg@bitbucket.org/appveyor-ruamel/yaml --branch default"

#tstvenv: testvenv testsetup testtest
#
#testvenv:
#	virtualenv -p /opt/python/2.7/bin/python testvenv
#
#testsetup:
#	testvenv/bin/pip install -e .
#	testvenv/bin/pip install pytest
#
#testtest:
#	testvenv/bin/py.test
