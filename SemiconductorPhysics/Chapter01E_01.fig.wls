#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]

SetDirectory[NotebookDirectory[]];

Needs["MaTeX`"];
SetDirectory[NotebookDirectory[]];
Unprotect[MaTeX`Developer`Texify];
MaTeX`Developer`Texify[TextCell[code_,___]]:=ToString[code]

nbFileName="Chapter01E_01.fig.wls";
nbPDFName="build/"<>StringReplace[nbFileName,"wls"->"pdf"];
nbPDFNameList=(StringReplace[nbPDFName,".fig"->#<>".fig"]&)/@Alphabet[];
Export[nbPDFName,""]


Ap=4
Bp=1
Cp=5


k:=Sqrt[x^2+y^2+z^2]
H[x_,y_,z_]:=-(Ap k^2-Sqrt[Bp^2 k^4+Cp^2 (x^2 y^2+y^2 z^2+z^2 x^2)])
L[x_,y_,z_]:=-(Ap k^2+Sqrt[Bp^2 k^4+Cp^2 (x^2 y^2+y^2 z^2+z^2 x^2)])
T[x_,y_,z_]:=-0.4-Ap k^2

(* eqE_V1.pdf *)
fig1=ContourPlot3D[H[x,y,z],
{x,-1.2,1.2},
{y,-1.2,1.2},
{z,-1.2,1.2},
AxesLabel->Automatic,
ContourStyle->LightBlue,
Contours->{-1},
ViewVector->{800,-1000,600}]

(* eqE_V2.pdf *)
fig2=ContourPlot3D[L[x,y,z],
{x,-0.6,0.6},
{y,-0.6,0.6},
{z,-0.6,0.6},
AxesLabel->Automatic,
ContourStyle->LightBlue,
Contours->{-1},
ViewVector->{800,-1000,600}]

(* eqE_V3.pdf *)
fig3=ContourPlot3D[T[x,y,z],
{x,-0.6,0.6},
{y,-0.6,0.6},
{z,-0.6,0.6},
AxesLabel->Automatic,
ContourStyle->LightBlue,
Contours->{-1},
ViewVector->{800,-1000,600}]

Ex[x_,y_,z_,x0_,y0_,z0_,a_,b_,c_]:=(x-x0)^2/a^2+(y-y0)^2/b^2+(z-z0)^2/c^2

(* eqE_C *)
fig4=ContourPlot3D[
{
Ex[x,y,z,+0.8,0,0,0.4,0.2,0.2]==1,
Ex[x,y,z,-0.8,0,0,0.4,0.2,0.2]==1,
Ex[x,y,z,0,+0.8,0,0.2,0.4,0.2]==1,
Ex[x,y,z,0,-0.8,0,0.2,0.4,0.2]==1,
Ex[x,y,z,0,0,+0.8,0.2,0.2,0.4]==1,
Ex[x,y,z,0,0,-0.8,0.2,0.2,0.4]==1
},
{x,-1.2,1.2},
{y,-1.2,1.2},
{z,-1.2,1.2},
AxesLabel->Automatic,
ContourStyle->LightBlue,
PlotPoints->200,
ViewVector->{800,-1000,600}]

fig={fig1,fig2,fig3,fig4}

figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]
