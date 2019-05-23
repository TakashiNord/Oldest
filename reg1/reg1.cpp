// reg1.cpp : Defines the entry point for the application.
//

#include "stdafx.h"
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#define BUFFER 256

/*======================================================================================*/

int issueError (FILE * log_file,int ecode, char *format, ... )
{
   va_list   ap;
   char      buffer[256];buffer[0]='\0';

   va_start( ap, format );
   if( ecode != 0 )
   {
     if (log_file!=NULL) fprintf( log_file, "Error %d: %s\n", ecode, buffer );
   }
   if (log_file!=NULL) vfprintf( log_file, format, ap );
   va_end( ap );
   return(0);
}

/*======================================================================================*/

int ScanReg(LPSTR  );
DWORD InfoReg(void);

int APIENTRY WinMain(HINSTANCE hInstance,
                     HINSTANCE hPrevInstance,
                     LPSTR     lpCmdLine,
                     int       nCmdShow)
{
 	// TODO: Place code here.
 	ScanReg(lpCmdLine);
 	//InfoReg();
 	//DeleteReg();
 	
 	return 0;

}


int ScanReg(LPSTR  lpLine)
{
 	// TODO: Place code here.
    HKEY hKey;
    DWORD dwResult;            // function return value
    char   Buf[MAX_PATH];
    CHAR   lpBuffer[128];

    char filename[BUFFER];
    FILE *wf;

    filename[0]='\0';
	strcpy (filename,"\\\\fs_opu\\Public\\galanin\\reg2006.txt");

    wf=fopen(filename,"a");
    if (wf==NULL) {  return (0) ; }

	issueError(wf,0,"\n===========================================");

    LPTSTR lpszSystemInfo;     // pointer to system information string
    char chComputerName [256],chInfoUserName [256];
    char chStr [512];
    DWORD cchBuff = 256;       // size of computer or user name
    TCHAR tchBuffer1[BUFFER],tchBuffer2[BUFFER];   // buffer for expanded string

    lpszSystemInfo = tchBuffer1;
    // Get and display the user name.
    GetUserName(lpszSystemInfo, &cchBuff);
    sprintf(chInfoUserName, "%s", lpszSystemInfo);

    //if ( lstrcmpi( "chudoyakoveb68", lpszSystemInfo) == 0 ) MessageBox("Шалом - Я Лена",NULL,MB_OK);

    lpszSystemInfo = tchBuffer2;
    // Get and display the name of the computer.
    GetComputerName(lpszSystemInfo, &cchBuff);
    sprintf(chComputerName, "%s", lpszSystemInfo);

    Buf[0] = '\0';
    sprintf(Buf, "> - %s (%s) \n", chInfoUserName,chComputerName);
    issueError(wf,0,Buf);

    chStr[0]='\0';
    strcpy(chStr,"Software\\Microsoft\\Exchange\\Messenger\\Profiles\\http://im.knaapo.ru/instmsg/aliases/");
    strcat(chStr,chInfoUserName);
    strcat(chStr,"\\Contacts");

	issueError(wf,0,chStr);
	issueError(wf,0,"\n");

    //hKey=HKEY_CURRENT_USER;

    // Use RegOpenKeyEx() with the new
    // Registry path to get an open handle
    // to the child key you want to enumerate.
    dwResult = RegOpenKeyEx (HKEY_CURRENT_USER,
                             TEXT(chStr),
                             0,
                             KEY_ENUMERATE_SUB_KEYS |
                             KEY_EXECUTE |
                             KEY_QUERY_VALUE,
                             &hKey);

    if (dwResult != ERROR_SUCCESS)
    {
         Buf[0] = '\0';
         sprintf(Buf, "ERROR open registry - %s (%s)", chInfoUserName,chComputerName);
         issueError(wf,0,Buf);
         if (wf!=NULL) { fclose(wf); }
         return (0);
    }


    CHAR     KeyName[MAX_PATH];
    CHAR     ClassName[MAX_PATH] = ""; // Buffer for class name.
    DWORD    dwcClassLen = MAX_PATH;   // Length of class string.
    DWORD    dwcSubKeys;               // Number of sub keys.
    DWORD    dwcMaxSubKey;             // Longest sub key size.
    DWORD    dwcMaxClass;              // Longest class string.
    DWORD    dwcValues;                // Number of values for this key.
    DWORD    dwcMaxValueName;          // Longest Value name.
    DWORD    dwcMaxValueData;          // Longest Value data.
    DWORD    dwcSecDesc;               // Security descriptor.
    FILETIME ftLastWriteTime;          // Last write time.

    int i, j;
    CHAR  ValueName[BUFFER];
    DWORD dwcValueName = BUFFER;
    DWORD dwMaxPath;
    FILETIME ftFileTime;

    // Get Class name, Value count.

    RegQueryInfoKey (hKey,              // Key handle.
                     ClassName,         // Buffer for class name.
                     &dwcClassLen,      // Length of class string.
                     NULL,              // Reserved.
                     &dwcSubKeys,       // Number of sub keys.
                     &dwcMaxSubKey,     // Longest sub key size.
                     &dwcMaxClass,      // Longest class string.
                     &dwcValues,        // Number of values for this key.
                     &dwcMaxValueName,  // Longest Value name.
                     &dwcMaxValueData,  // Longest Value data.
                     &dwcSecDesc,       // Security descriptor.
                     &ftLastWriteTime); // Last write time.

    // Loop until RegEnumKey fails, get
    // the name of each child and enter
    // it into the box.

    // Enumerate the Child Keys.

/*
    for (i=0, dwResult = ERROR_SUCCESS; dwResult == ERROR_SUCCESS; i++)
    {

        dwMaxPath = MAX_PATH;
        dwResult = RegEnumKeyEx( hKey,(DWORD)i, KeyName,
                                &dwMaxPath, NULL, NULL,
                                NULL,  &ftFileTime);

        if (dwResult == (DWORD)ERROR_SUCCESS) {
            Buf[0] = '\0';
            sprintf(Buf, "KeyName - %s", KeyName);
            issueError(wf,0,Buf);
        }

    }
*/
    // Enumerate the Key Values

    if (dwcValues)
        for (j = 0, dwResult = ERROR_SUCCESS; (DWORD)j < dwcValues; j++)
        {
            dwcValueName = BUFFER;
            ValueName[0] = '\0';
            dwResult = RegEnumValue (hKey, (DWORD)j, ValueName,
                                     &dwcValueName,
                                     NULL,
                                     NULL,               //&dwType,
                                     NULL,               //&bData,
                                     NULL);              //&bcData);
            if (dwResult != (DWORD)ERROR_SUCCESS &&
                dwResult != ERROR_INSUFFICIENT_BUFFER)
            {
                Buf[0] = '\0';
                sprintf(Buf, "Error = - %d \n", dwcValueName);
                issueError(wf,1,Buf);
            }

            Buf[0] = '\0';
            if (ValueName[0] == '\0')
            {
                strncpy (ValueName, lpBuffer,80);
            }
            sprintf (Buf, "%d) %s \n", j, ValueName);
			issueError(wf,0,Buf);

        }// end for(;;)

    RegCloseKey (hKey);   // Close the key handle.


	issueError(wf,0,"\n===========================================\n");

    if (wf!=NULL) { fclose(wf); }

    return 0;

}



#define RTN_UNKNOWN 0
#define RTN_SERVER 1
#define RTN_WORKSTATION 2
#define RTN_NTAS 3
#define RTN_ERROR 13

DWORD InfoReg(void)
{
    #define MY_BUFSIZE 32    // Arbitrary initial value. 
                             // Dynamic allocation will be used.
    HKEY hKey;
    TCHAR szProductType[MY_BUFSIZE];
    DWORD dwBufLen = MY_BUFSIZE;
    LONG lRet;

    if(RegOpenKeyEx(HKEY_CURRENT_USER,
        TEXT("Software\\Microsoft\\Exchange"),
                    0,
                    KEY_QUERY_VALUE,
                    &hKey) != ERROR_SUCCESS) return RTN_ERROR;

    lRet = RegQueryValueEx(hKey,
                    TEXT("chudoyakoveb68"),
                    NULL,
                    NULL,
                    (LPBYTE)szProductType,
                    &dwBufLen);

    RegCloseKey(hKey);

    if(lRet != ERROR_SUCCESS) return RTN_ERROR;

//AfxMessageBox(szProductType);


   if(RegOpenKeyEx(HKEY_CURRENT_USER,
        TEXT("Software\\Microsoft\\Exchange"),
                    0,
                    KEY_ALL_ACCESS,
                    &hKey) != ERROR_SUCCESS) return RTN_ERROR;

    lRet = RegQueryValueEx(hKey,
                    TEXT("chudoyakoveb68"),
                    NULL,
                    NULL,
                    (LPBYTE)szProductType,
                    &dwBufLen);

   if(lRet == ERROR_SUCCESS) 
 
   RegDeleteValue(hKey, TEXT("chudoyakoveb68"));

   RegCloseKey(hKey);

   return 0;
} 



DWORD DeleteReg(void)
{
    #define MY_BUFSIZE 32    // Arbitrary initial value.
                             // Dynamic allocation will be used.
    HKEY hKey;
    TCHAR szProductType[BUFFER];
    DWORD dwBufLen = BUFFER;
    LONG lRet;
/**/

LPTSTR lpszSystemInfo;     // pointer to system information string
char chComputerName [256],chInfoUserName [256];
char chStr [512];
DWORD cchBuff = 256;       // size of computer or user name
TCHAR tchBuffer2[BUFFER];  // buffer for concatenated string

DWORD dwResult;            // function return value

SYSTEM_INFO siSysInfo;     // structure for hardware information
int aTabs[1] = {260};      // tab stop for TabbedTextOut

TCHAR tchBuffer[BUFFER];   // buffer for expanded string
int nSize;                 // size of string

lpszSystemInfo = tchBuffer2;


// Get and display the user name.
GetUserName(lpszSystemInfo, &cchBuff);
nSize = sprintf(tchBuffer, "User name:  %s", lpszSystemInfo);
sprintf(chInfoUserName, "%s", lpszSystemInfo);
//TextOut(hdc, 15, 40, tchBuffer, nSize);
//AfxMessageBox(tchBuffer);
//if ( lstrcmpi( "chudoyakoveb68", lpszSystemInfo) == 0 ) MessageBox("Шалом - Я Лена");
            
// Get and display the name of the computer.
GetComputerName(lpszSystemInfo, &cchBuff);
nSize = sprintf(tchBuffer, "Computer name:  %s",lpszSystemInfo);
sprintf(chComputerName, "%s", lpszSystemInfo);
//TextOut(hdc, 15, 20, tchBuffer, nSize);


// Get and display the system directory.
nSize = GetSystemDirectory(lpszSystemInfo, MAX_PATH+1);
nSize = sprintf(tchBuffer, "System directory:  %s", lpszSystemInfo);
//TextOut(hdc, 15, 60, tchBuffer, nSize);

// Get and display the Windows directory.
nSize = GetWindowsDirectory(lpszSystemInfo, MAX_PATH+1);
nSize = sprintf(tchBuffer, "Windows directory:  %s", lpszSystemInfo);
//TextOut(hdc, 15, 80, tchBuffer, nSize);

// Display the "environment variables" header.
nSize = sprintf(tchBuffer, "Environment variables (partial list):");
//TextOut(hdc, 15, 105, tchBuffer, nSize);

// Expand the OS and NTVERSION environment variables.
dwResult = ExpandEnvironmentStrings("OS=%OS%     NTVERSION=%NTVERSION%", lpszSystemInfo, BUFFER);
//TextOut(hdc, 25, 120, (LPCTSTR) lpszSystemInfo, dwResult - 1);

// Expand the PATH environment variable.
dwResult = ExpandEnvironmentStrings( "PATH=%PATH%", lpszSystemInfo, BUFFER);
//TextOut(hdc, 25, 135, (LPCTSTR) lpszSystemInfo, dwResult - 1);

// Expand the LIBPATH environment variable.
dwResult = ExpandEnvironmentStrings( "LIBPATH=%LIBPATH%", lpszSystemInfo, BUFFER);
//TextOut(hdc, 25, 150, (LPCTSTR) lpszSystemInfo, dwResult - 1);

// Expand the TMP environment variable.
dwResult = ExpandEnvironmentStrings( "TMP=%TMP%", lpszSystemInfo, BUFFER);
//TextOut(hdc, 25, 165, (LPCTSTR) lpszSystemInfo,  dwResult - 1);


/*Удаление рожы*/

   chStr[0]='\0';
   strcpy(chStr,"Software\\Microsoft\\Exchange\\Messenger\\Profiles\\http://im.knaapo.ru/instmsg/aliases/");
   strcat(chStr,chInfoUserName);
   strcat(chStr,"\\Contacts");

   if(RegOpenKeyEx(HKEY_CURRENT_USER,
        TEXT(chStr),
                    0,
                    KEY_ALL_ACCESS,
                    &hKey) != ERROR_SUCCESS) return RTN_ERROR;

	lRet = RegQueryValueEx(hKey,
                    TEXT("chudoyakoveb68@im.knaapo.ru"),
                    NULL,
                    NULL,
                    (LPBYTE)szProductType,
                    &dwBufLen);

	if(lRet == ERROR_SUCCESS)
		RegDeleteValue(hKey,"chudoyakoveb68@im.knaapo.ru");

    RegCloseKey(hKey);

    if(lRet != ERROR_SUCCESS) return RTN_ERROR;

    // return "unknown variant" code
    return RTN_UNKNOWN;
}
