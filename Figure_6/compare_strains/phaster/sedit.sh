for i in *.txt; do sed -i '/REGION/,$!d' $i; sed -i -e 's/\s\+/\t/g'  -e '/--------/d' $i; done

