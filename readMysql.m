function [myObject, myEventdata] = readMysql(n, myObject, myEventdata)
    % n = 1;
    conc = database('netdesign', 'root', '123', 'com.mysql.jdbc.Driver', 'jdbc:mysql://localhost:3306/netdesign');
    n = n - 1;
    
    % ---�����ݿ��ж�ȡmyObject.mytrack������-----
    curs = exec(conc, "select * from mytrack limit " + n + "," + "1");
    curs = fetch(curs);
    dat = curs.Data;
    myObject.myTrack.TrackX = combstr2mat(dat{1});
    myObject.myTrack.TrackY = combstr2mat(dat{2});
    myObject.myTrack.TrackPoint = double(dat{3});
    myObject.myTrack.TrackN = double(dat{4});
    myObject.myTrack.Interval = double(dat{5});
    myObject.myTrack.Step = double(dat{6});
    myObject.myTrack.LineCell = combstr2Line(dat{7});
    myObject.myTrack.CircleCell = combstr2Circle(dat{8});

    % ---�����ݿ��ж�ȡmyObject.myRtx������-----
    curs = exec(conc, "select * from myRtx limit " + n + "," + "1");
    curs = fetch(curs);
    dat = curs.Data;
    myObject.myRtx.MatTx = combstr2mat(dat{1});
    myObject.myRtx.MatRx = combstr2mat(dat{2});
    myObject.myRtx.ApX = combstr2mat(dat{3});
    myObject.myRtx.ApY = combstr2mat(dat{4});
    myObject.myRtx.SignalFre = str2double(dat{5});
    myObject.myRtx.Threshold = (dat{6});
    myObject.myRtx.ApRange = combstr2mat(dat{7});
    
    % ---�����ݿ��ж�ȡmyObject.myInterf������-----
    curs = exec(conc, "select * from myInterf limit " + n + "," + "1");
    curs = fetch(curs);
    dat = curs.Data;
    myObject.myInterf.Interf1 = combstr2mat(dat{1});
    myObject.myInterf.Interf2 = combstr2mat(dat{2});
    myObject.myInterf.InterfX = combstr2mat(dat{3});
    myObject.myInterf.InterfY = combstr2mat(dat{4});
    myObject.myInterf.NoisePower = double(dat{5});
    myObject.myInterf.MatTx = combstr2mat(dat{6});
    
    % ---�����ݿ��ж�ȡmyObject.myCost������-----
    curs = exec(conc, "select * from myCost limit " + n + "," + "1");
    curs = fetch(curs);
    dat = curs.Data;
    myObject.myCost.alpha = double(dat{1});
    myObject.myCost.beta = double(dat{2});
    myObject.myCost.gama = double(dat{3});
    
    % ---�����ݿ��ж�ȡmyObject.myScene������-----
    curs = exec(conc, "select * from myScene limit " + n + "," + "1");
    curs = fetch(curs);
    dat = curs.Data;
    myObject.myScene.myCurrentScene = dat{2};
    
    close(conc);
% end