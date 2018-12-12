#!/bin/bash

for file in /opt/csv/availability/*.csv;
do

        sed -i '1,8d' $file
        cp "$file" "${file%.csv}.pre"
done

mv /opt/csv/availability/*.pre /opt/csv/availability/processed

for file in /opt/csv/availability/processed/*.pre;
do

         mv "$file" "${file%.pre}.csv"
done

for file in /opt/csv/availability/processed/*.csv;
do

           sed -i '$ d' $file
done


for file in /opt/csv/availability/processed/*.csv;
do

                   sed -i 's/ IST//g' $file
           
done


for file in /opt/csv/availability/processed/*.csv;
do

        awk 'BEGIN{FS=OFS= ","}
        { 

                split ( $3, date, " " ) 
         
                $3 = date[5] "-" date[2] "-" date[3] " " date[4]


                split ( $4, date, " " )

                $4 = date[5] "-" date[2] "-" date[3] " " date[4]


                print $0
        } ' $file

done


rm -Rf /opt/csv/availability/processed/availa*
