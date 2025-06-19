#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]

SetDirectory[NotebookDirectory[]];

Needs["MaTeX`"];
SetDirectory[NotebookDirectory[]];
Unprotect[MaTeX`Developer`Texify];
MaTeX`Developer`Texify[TextCell[code_,___]]:=ToString[code]

nbFileName="Chapter05G_01.fig.wls";
nbPDFName="build/"<>StringReplace[nbFileName,"wls"->"pdf"];
nbPDFNameList=(StringReplace[nbPDFName,".fig"->#<>".fig"]&)/@Alphabet[];
Export[nbPDFName,""]

Lp=1

p1[x_]:=Exp[-(x/Lp)]
p2[x_,W_]:=Sinh[(W-x)/Lp]/Sinh[W/Lp]

(* DeltP *)
fig1=Plot[{p2[x,0.5],p2[x,1],p2[x,1.5],p2[x,2],p2[x,2.5],p1[x]},{x,0,5},
PlotRange->{0,1},
GridLines->Automatic,
Frame->True,
FrameStyle->BlackFrame,
PlotStyle->ColorData[10],
BaseStyle->{FontFamily->"Latin Modern Roman",FontSize->8},
FrameLabel->{
MaTeX["x/L_\\text{p}"],
MaTeX["\\Delta p/(\\Delta p)_0"],
MaTeX["\\vphantom{\\frac{x}{y}}"]},
PlotLegends->LineLegend[
{
Text[Style["薄样品"MaTeX["W=0.5L_\\text{p}"],FontSize->10]],
Text[Style["薄样品"MaTeX["W=1.0L_\\text{p}"],FontSize->10]],
Text[Style["薄样品"MaTeX["W=1.5L_\\text{p}"],FontSize->10]],
Text[Style["薄样品"MaTeX["W=2.0L_\\text{p}"],FontSize->10]],
Text[Style["薄样品"MaTeX["W=2.5L_\\text{p}"],FontSize->10]],
Text[Style["厚样品"MaTeX["W\\to\\infty"],FontSize->10]]
},
LegendFunction->(Framed[#,RoundingRadius->1,FrameStyle->{Thin}]&),
LegendMargins->1]]

deltP[x_,t_,Np_,Dp_,mup_,tau_,Emf_]:=Np/Sqrt[4Pi Dp t] Exp[-((x-mup Emf t)^2/( 4 Dp t))-t/tau]
deltP1[x_,t_]:=deltP[x,t,1,1,1,1,1]


(* DeltPExp *)
fig2=Plot[Evaluate[Table[deltP1[x,T],{T,{0.000015,0.25,0.50,1.00,2.00,4.00}}]],{x,-2,8},
PlotRange->{-0.02,0.52},
GridLines->Automatic,
Frame->True,
FrameStyle->BlackFrame,
PlotStyle->ColorData[10],
BaseStyle->{FontFamily->"Latin Modern Roman",FontSize->8},
FrameLabel->{
MaTeX["x"],
MaTeX["\\Delta p"],
MaTeX["\\vphantom{\\frac{x}{y}}"]},
PlotLegends->LineLegend[
{MaTeX["t=0.00"],MaTeX["t=0.25"],MaTeX["t=0.50"],MaTeX["t=1.00"],MaTeX["t=2.00"],MaTeX["t=4.00"]},
LegendFunction->(Framed[#,RoundingRadius->1,FrameStyle->{Thin}]&),
LegendMargins->1]]

fig={fig1,fig2}

figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]
