function [myObject, myEventdata] = cm_select(myObject, myEventdata)
% myObeject ȫ�ֽṹ��,��������ȫ�ֱ���,��ŵ���һЩ����Ҫ�á�ͨ���Ҳ��������
% eventdata �����������Ա���ʱ֮��
% myhandles �ֲ��ṹ�壬���ں������úͱ�����ʱ������
% ���������Ϊ���жϵ�ǰ�������ó�������Ҫʹ�õ�ģ��
% ѡ��ͬ���ź�ģ��ֻ��Ϊ�˼�����ջ����ܵ����źŵľ�ֵ�������Ǽ��� �źž�ֵ
%   �˴���ʾ��ϸ˵��
switch myObject.myScene.myCurrentScene
    case myObject.myScene.mySceneLib{1} %
          myObject.myScene.myCurrentMod = myObject.myScene.mySceneMod.Plain;
      %    [myEventdata.OptMeanPower.M0, myEventdata.OptMeanPower.M1, myEventdata.OptMeanPower.M2] = LogDistancePLSF(myObject,myEventdata);
          
    case myObject.myScene.mySceneLib{2}
          myObject.myScene.myCurrentMod = myObject.myScene.mySceneMod.Mountain;
      %    [myEventdata.OptMeanPower.M0, myEventdata.OptMeanPower.M1, myEventdata.OptMeanPower.M2] = OtherPLSF(myObject,myEventdata);
    case myObject.myScene.mySceneLib{5}
          myObject.myScene.myCurrentMod = myObject.myScene.mySceneMod.Import;
          
    otherwise % ��������
          myObject.myScene.myCurrentMod = myObject.myScene.mySceneMod.Plain;
end
        
end

