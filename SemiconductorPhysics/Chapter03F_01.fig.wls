#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]

SetDirectory[NotebookDirectory[]];

Needs["MaTeX`"];
SetDirectory[NotebookDirectory[]];
Unprotect[MaTeX`Developer`Texify];
MaTeX`Developer`Texify[TextCell[code_,___]]:=ToString[code]

nbFileName="Chapter03F_01.fig.wls";
nbPDFName="build/"<>StringReplace[nbFileName,"wls"->"pdf"];
nbPDFNameList=(StringReplace[nbPDFName,".fig"->#<>".fig"]&)/@Alphabet[];
Export[nbPDFName,""]

F[x_]:=-(1/2) Sqrt[\[Pi]] PolyLog[3/2,-E^x]

(* FermiFunc *)
fig1=Plot[{2x,F[x]},{x,0,14},
Frame->True,
GridLines->Automatic,
PlotRange->{-1,30},
ImageSize->Medium,
PlotStyle->{{Gray,Dashed},Black},
PlotLegends->{MaTeX["2\\xi"],MaTeX["\\text{F}_{1/2}(\\xi)"]}]

(* FermiFuncLog *)
fig2=LogPlot[{2x,F[x]},{x,0,14},
Frame->True,
GridLines->Automatic,
PlotRange->{0.51,50},
ImageSize->Medium,
PlotStyle->{{Gray,Dashed},Black},
PlotLegends->{MaTeX["2\\xi"],MaTeX["\\text{F}_{1/2}(\\xi)"]}]

(* Degenerate *)
fig3=Plot[{Exp[x],2/Sqrt[Pi] F[x]},{x,-2.5,10},
Frame->True,
GridLines->Automatic,
PlotRange->{-5,100},
ImageSize->Medium,
PlotStyle->{{Blue,Dashed},Red},
RotateLabel->False,
FrameLabel->{MaTeX["E_\\text{F}-E_\\text{c}/k_\\text{B}T"],MaTeX["n_0/N_\\text{c}"]},
PlotLegends->LineLegend[{
MaTeX["\\text{\\footnotesize $N_\\text{c}
\\exp\\left(\\frac{E_\\text{F}-E_\\text{c}}{k_\\text{B}T}\\right)$}"],
MaTeX["\\text{\\footnotesize $N_\\text{c}\\frac{2}{\\sqrt{\\pi}}
\\text{F}_{1/2}\\left(\\frac{E_\\text{F}-E_\\text{c}}{k_\\text{B}T}\\right)$}"]},LegendFunction->(Framed[#,RoundingRadius->1,FrameStyle->{Thin}]&),LegendMargins->5]]

(* DegenerateLog *)
fig4=LogPlot[{Exp[x],2/Sqrt[Pi] F[x]},{x,-2.5,10},
Frame->True,
GridLines->Automatic,
PlotRange->{0.05,100},
ImageSize->Medium,
PlotStyle->{{Blue,Dashed},Red},
RotateLabel->False,
FrameLabel->{MaTeX["E_\\text{F}-E_\\text{c}/k_\\text{B}T"],MaTeX["n_0/N_\\text{c}"]},
PlotLegends->LineLegend[{
MaTeX["\\text{\\footnotesize $N_\\text{c}
\\exp\\left(\\frac{E_\\text{F}-E_\\text{c}}{k_\\text{B}T}\\right)$}"],
MaTeX["\\text{\\footnotesize $N_\\text{c}\\frac{2}{\\sqrt{\\pi}}
\\text{F}_{1/2}\\left(\\frac{E_\\text{F}-E_\\text{c}}{k_\\text{B}T}\\right)$}"]},LegendFunction->(Framed[#,RoundingRadius->1,FrameStyle->{Thin}]&),LegendMargins->5]]

(* DegenerateCT *)
Subscript[N, D][T_,dED_]:=T^(3/2) (1+2Exp[(11604*dED)/T])*(3.28 10^15)
fig5=LogPlot[{Subscript[N, D][T,0.01],Subscript[N, D][T,0.02],Subscript[N, D][T,0.03],Subscript[N, D][T,0.04],Subscript[N, D][T,0.05]},{T,0,1000},
PlotRange->{10^19,10^23},
Frame->True,
GridLines->Automatic,
FrameLabel->{
MaTeX["T/\\si{K}","Preamble"->{"\\usepackage{siunitx}"}],
MaTeX["N_\\text{D}/(m_\\text{n}^{*}/m_0)^{3/2}"]},
PlotLegends->LineLegend[{
MaTeX["\\text{\\footnotesize $\\Delta E_\\text{D}=0.01\\si{eV}$}","Preamble"->{"\\usepackage{siunitx}"}],
MaTeX["\\text{\\footnotesize $\\Delta E_\\text{D}=0.02\\si{eV}$}","Preamble"->{"\\usepackage{siunitx}"}],
MaTeX["\\text{\\footnotesize $\\Delta E_\\text{D}=0.03\\si{eV}$}","Preamble"->{"\\usepackage{siunitx}"}],
MaTeX["\\text{\\footnotesize $\\Delta E_\\text{D}=0.04\\si{eV}$}","Preamble"->{"\\usepackage{siunitx}"}],
MaTeX["\\text{\\footnotesize $\\Delta E_\\text{D}=0.05\\si{eV}$}","Preamble"->{"\\usepackage{siunitx}"}]
},
LegendFunction->(Framed[#,RoundingRadius->1,FrameStyle->{Thin}]&),
LegendMargins->5],
PlotStyle->ColorData[10]]

fig={fig1,fig2,fig3,fig4,fig5}

figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]
