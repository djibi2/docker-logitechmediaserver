LMS_LATEST=$(shell wget -O - -q "http://www.mysqueezebox.com/update/?version=7.9.0&revision=1&geturl=1&os=deb")
TAG=$(shell echo $(LMS_LATEST) | sed -e s/[^_]*_// | sed -e s/_all.deb// | sed -e s/~/-/)
USER=justifiably

update:
	if [ "`cat lms-version.txt`" = "$(TAG)" ]; then echo "No update available"; exit 1; fi
	echo -n $(TAG) > lms-version.txt
	wget $(LMS_LATEST) -O - > lms.deb

build:
	OTAG=`cat lms-version.txt`; docker build -t $(USER)/logitechmediaserver:$$OTAG .; docker tag $(USER)/logitechmediaserver:$$OTAG $(USER)/logitechmediaserver:latest