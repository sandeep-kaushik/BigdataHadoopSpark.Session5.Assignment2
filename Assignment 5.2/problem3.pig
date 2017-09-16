REGISTER '/home/acadgild/pig/airline_usecase/piggybank.jar';
 
A = load '/home/acadgild/pig/airline_usecase/DelayedFlights.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',','NO_MULTILINE','UNIX','SKIP_INPUT_HEADER');
 
B1 = foreach A generate (int)$16 as dep_delay, (chararray)$17 as origin;
 
C1 = filter B1 by (dep_delay is not null) AND (origin is not null);
 
D1 = group C1 by origin;
 
E1 = foreach D1 generate group, AVG(C1.dep_delay);
 
Result = order E1 by $1 DESC;
 
Top_ten = limit Result 10;
 
Lookup = load '/home/acadgild/pig/airline_usecase/airports.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',','NO_MULTILINE','UNIX','SKIP_INPUT_HEADER');
 
Lookup1 = foreach Lookup generate (chararray)$0 as origin, (chararray)$2 as city, (chararray)$4 as country;
 
Joined = join Lookup1 by origin, Top_ten by $0;
 
Final = foreach Joined generate $0,$1,$2,$4;
 
Final_Result = ORDER Final by $3 DESC;
 
store Final_Result into '/home/acadgild/Desktop/5.2/output/problem3';
