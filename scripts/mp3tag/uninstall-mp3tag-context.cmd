@echo off
reg delete "HKCU\SOFTWARE\Classes\*\shell\&Mp3tag" /f
reg delete "HKCU\SOFTWARE\Classes\*\shell\Mp3tag" /f
