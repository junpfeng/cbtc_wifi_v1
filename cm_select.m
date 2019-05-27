function [myObject, myEventdata] = cm_select(myObject, myEventdata)
% myObeject 全局结构体,用来传递全局变量,存放的是一些必须要用、通用且不变的数据
% eventdata 保留变量，以备不时之需
% myhandles 局部结构体，用于函数调用和被调用时，传参
% 这个函数是为了判断当前场景即该场景下需要使用的模型
% 选择不同的信号模型只是为了计算接收机接受到的信号的均值，核心是计算 信号均值
%   此处显示详细说明
switch myObject.myScene.myCurrentScene
    case myObject.myScene.mySceneLib{1} %
          myObject.myScene.myCurrentMod = myObject.myScene.mySceneMod.Plain;
      %    [myEventdata.OptMeanPower.M0, myEventdata.OptMeanPower.M1, myEventdata.OptMeanPower.M2] = LogDistancePLSF(myObject,myEventdata);
          
    case myObject.myScene.mySceneLib{2}
          myObject.myScene.myCurrentMod = myObject.myScene.mySceneMod.Mountain;
      %    [myEventdata.OptMeanPower.M0, myEventdata.OptMeanPower.M1, myEventdata.OptMeanPower.M2] = OtherPLSF(myObject,myEventdata);
    case myObject.myScene.mySceneLib{5}
          myObject.myScene.myCurrentMod = myObject.myScene.mySceneMod.Import;
          
    otherwise % 再作补充
          myObject.myScene.myCurrentMod = myObject.myScene.mySceneMod.Plain;
end
        
end

