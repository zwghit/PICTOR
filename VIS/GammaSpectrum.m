close all, clear all 
%% This script shows velocity spectrum of particles
DataFolder='/Users/rahulkumar/Dropbox/NumericalCodes/PICTOR/data';
TimeSteps=100:100:5000;
flvID=[3 4 5 6 7 8];
flvID=[1 2];
Color=['g','r','k','b','m','c'];
%%=====================================================================
CurrentFolder=pwd;
cd(DataFolder)
compe=double(h5read('param','/compe'));
c=double(h5read('param','/c'));


for t=TimeSteps
    FileName=strcat('spec_',num2str(t));
    gspec=h5read(FileName,'/gspec');
    gbin=h5read(FileName,'/gbin');
    
    if(~exist('h1'))
        fig=figure;
        for k=1:length(flvID)
            h1(k)=loglog(gbin,gspec(flvID(k),:),Color(k));
            hold on
            set(h1(k),'XDataSource','gbin','YDataSource','gspec(flvID(k),:)')
        end
        set(gca,'FontSize',12)
        %xlim([1 10])
    else
        pause(1.0)
        for k=1:length(flvID)
            refreshdata(h1(k),'caller')
        end
        drawnow;
    end
    str=t*c/compe;
    title(strcat(num2str(str),'\omega_{pe}^{-1}'))
    
end
cd(CurrentFolder)