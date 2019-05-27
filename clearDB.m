function clearDB()
   conc = database('netdesign', 'root', '123', 'com.mysql.jdbc.Driver', 'jdbc:mysql://localhost:3306/netdesign');
   exec(conc, 'truncate mycost');
   exec(conc, 'truncate myinterf');
   exec(conc, 'truncate myreg');
   exec(conc, 'truncate myrtx');
   exec(conc, 'truncate myscene');
   exec(conc, 'truncate mytrack');
   close(conc);
end