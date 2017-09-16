
REGISTER '/home/acadgild/pig/airline_usecase/piggybank.jar';
 
A = load '/home/acadgild/pig/airline_usecase/DelayedFlights.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',','NO_MULTILINE','UNIX','SKIP_INPUT_HEADER');
 
B = foreach A generate (int)$2 as month,(int)$10 as flight_num,(int)$22 as cancelled,(chararray)$23 as cancel_code;
 
C = filter B by cancelled == 1 AND cancel_code =='B';
 
D = group C by month;
 
E = foreach D generate group, COUNT(C.cancelled);
 
F= order E by $1 DESC;
 
Result = limit F 1;
 
store Result into '/home/acadgild/Desktop/5.2/output/problem2';
