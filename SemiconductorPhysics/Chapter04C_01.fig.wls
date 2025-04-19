#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]

SetDirectory[NotebookDirectory[]];

Needs["MaTeX`"];
SetDirectory[NotebookDirectory[]];
Unprotect[MaTeX`Developer`Texify];
MaTeX`Developer`Texify[TextCell[code_,___]]:=ToString[code]

nbFileName="Chapter04C_01.fig.wls";
nbPDFName="build/"<>StringReplace[nbFileName,"wls"->"pdf"];nbPDFNameList=(StringReplace[nbPDFName,".fig"->#<>".fig"]&)/@Alphabet[];
Export[nbPDFName,""]

Subscript[k, B]=1.3806488 10^-23;
\[HBar]=1.054571726 10^-34 ;
Subscript[m, 0]=9.10938291 10^-31;
q=1.602176565 10^-19;

mu[m_,A_,B_,T_,NI_]:=q/m (A T^(3/2)+(B NI*100^3)/T^(3/2))^-1
Ae=4.7;
Be=-12.2;

(* MobilityT *)
fig1=LogLogPlot[{
mu[1.06 Subscript[m, 0],10^Ae,10^Be,T,1.0 10^13],
mu[1.06 Subscript[m, 0],10^Ae,10^Be,T,1.0 10^17],
mu[1.06 Subscript[m, 0],10^Ae,10^Be,T,2.0 10^17],
mu[1.06 Subscript[m, 0],10^Ae,10^Be,T,5.0 10^17],
mu[1.06 Subscript[m, 0],10^Ae,10^Be,T,1.0 10^18],
mu[1.06 Subscript[m, 0],10^Ae,10^Be,T,2.0 10^18],
mu[1.06 Subscript[m, 0],10^Ae,10^Be,T,5.0 10^18]
},
{T,200,600},
AspectRatio->16/9,
PlotRange->{50,1500},
Frame->True,
FrameStyle->BlackFrame,
GridLines->Automatic,
BaseStyle->{FontFamily->"Latin Modern Roman",FontSize->8},
FrameLabel->{
MaTeX["T/\\si{K}","Preamble"->{"\\usepackage{siunitx}"}],
MaTeX["\\mu/\\si{cm^2\\cdot V^{-1}\\cdot s^{-1}}","Preamble"->{"\\usepackage{siunitx}"}]},
PlotLegends->LineLegend[{
MaTeX["\\text{\\footnotesize $N_\\text{i}=1.0\\times 10^{13}$}","Preamble"->{"\\usepackage{siunitx}"}],
MaTeX["\\text{\\footnotesize $N_\\text{i}=1.0\\times 10^{17}$}","Preamble"->{"\\usepackage{siunitx}"}],
MaTeX["\\text{\\footnotesize $N_\\text{i}=2.0\\times 10^{17}$}","Preamble"->{"\\usepackage{siunitx}"}],
MaTeX["\\text{\\footnotesize $N_\\text{i}=5.0\\times 10^{17}$}","Preamble"->{"\\usepackage{siunitx}"}],
MaTeX["\\text{\\footnotesize $N_\\text{i}=1.0\\times 10^{18}$}","Preamble"->{"\\usepackage{siunitx}"}],
MaTeX["\\text{\\footnotesize $N_\\text{i}=2.0\\times 10^{18}$}","Preamble"->{"\\usepackage{siunitx}"}],
MaTeX["\\text{\\footnotesize $N_\\text{i}=5.0\\times 10^{18}$}","Preamble"->{"\\usepackage{siunitx}"}]
},
LegendFunction->(Framed[#,RoundingRadius->1,FrameStyle->{Thin}]&),
LegendMargins->5],
PlotStyle->ColorData[10]]

(* MobilityN *)
fig2=LogLogPlot[{
mu[1.06 Subscript[m, 0],10^Ae,10^Be,600,Nx],
mu[1.06 Subscript[m, 0],10^Ae,10^Be,500,Nx],
mu[1.06 Subscript[m, 0],10^Ae,10^Be,400,Nx],
mu[1.06 Subscript[m, 0],10^Ae,10^Be,300,Nx],
mu[1.06 Subscript[m, 0],10^Ae,10^Be,200,Nx]
},
{Nx,10^13,5 10^19},
AspectRatio->16/9,
PlotRange->{50,1500},
Frame->True,
FrameStyle->BlackFrame,
GridLines->Automatic,
BaseStyle->{FontFamily->"Latin Modern Roman",FontSize->8},
FrameLabel->{
MaTeX["N/\\si{cm^{-3}}","Preamble"->{"\\usepackage{siunitx}"}],
MaTeX["\\mu/\\si{cm^2\\cdot V^{-1}\\cdot s^{-1}}","Preamble"->{"\\usepackage{siunitx}"}]},
PlotLegends->LineLegend[{
MaTeX["\\text{\\footnotesize $T=600\\si{K}$}","Preamble"->{"\\usepackage{siunitx}"}],
MaTeX["\\text{\\footnotesize $T=500\\si{K}$}","Preamble"->{"\\usepackage{siunitx}"}],
MaTeX["\\text{\\footnotesize $T=400\\si{K}$}","Preamble"->{"\\usepackage{siunitx}"}],
MaTeX["\\text{\\footnotesize $T=300\\si{K}$}","Preamble"->{"\\usepackage{siunitx}"}],
MaTeX["\\text{\\footnotesize $T=200\\si{K}$}","Preamble"->{"\\usepackage{siunitx}"}]
},
LegendFunction->(Framed[#,RoundingRadius->1,FrameStyle->{Thin}]&),
LegendMargins->5],
PlotStyle->ColorData[10]]

fig={fig1,fig2}

figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]
