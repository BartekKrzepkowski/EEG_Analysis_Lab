function wd=eegblockfft(eegblock_,npfft,shift);

%windowflag: 0-box, 1-hamming, 2-hanning, 3-blackman

windowflag=2;
npwind=npfft;

%if windowflag==0; window=rectwin(npwind); end;
%if windowflag==1; window=hamming(npwind); end;
%if windowflag==2; window=hanning(npwind); end;
%if windowflag==3; window=blackman(npwind); end;
%if windowflag==4; window=kaiser(npwind,5); end;
n=1:npwind;
window=0.5*(1-cos(2*pi*n/(npwind-1)));
window=window';
%plot(window);
eegblock=eegblock_';

np=size(eegblock,1);
nch=size(eegblock,2);
%npfft=size(window,1);
windarea=sum(window(:,1));
window=repmat(window,1,nch);
wd=zeros(npfft/2-1,nch);
p1=1; p2=p1+npfft-1; n=0;

while p2<=np

n=n+1;
w=abs(fft(eegblock(p1:p2,:).*window,npfft,1));
w=w*2/windarea;
wd=wd+w(2:npfft/2,:);
p1=p1+shift; p2=p2+shift;

end;

if n>0 wd=wd/n; wd=wd'; end;