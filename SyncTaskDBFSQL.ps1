cd C:\DATA
dotnet DBFImport.dll --path "xx" --connectionstring "Server=xx;Database=xx;User Id=xx;Password=xx" --prefix "PREFIX_"


Function RunSQLQuery([string]$Query )
{
 <#
  .SYNOPSIS
   Executes SQL Query, such as Insert, Update, Delete, etc
  .DESCRIPTION
   This PowerShell function executes the provided SQL query on the provided Database.
  .EXAMPLE
   powershell sql server query update: " RunSQLQuery "G1VWFE01" "MigrationData" "UPDATE [Table-name] SET [SiteStatus]='CREATED' WHERE [SiteID] = '$SiteID' AND [Category] = '$Category' "
                 powershell sql server query insert: use the SQL query as: "INSERT INTO [TableName] ( [SourceSiteUrl], [TargetSiteUrl],  [SiteType] ) VALUES ('https://sharepoint2007.crescent.com','https://sharepoint2010.crescent.com', 'case')"
  .INPUTS
   DBServer - Name of the Database Sever where the "LVMAdmin" database is located
   DBName - NameNo value of the cases table
   Query - Query to execute. Such as Insert, Delete
  .OUTPUTS
   None
 #>
 try
 {
  #Connection object

$serverName = "xx"
$databaseName = "xx"
$username = "xx"
$password = "xx"


  $cn = new-object System.Data.SqlClient.SqlConnection("Server=$serverName;Database=$databaseName;User ID=$username;Password=$password;")
  $cn.open()
 
  $cmd = new-object "System.Data.SqlClient.SqlCommand" ($Query, $cn)
  $cmd.ExecuteNonQuery()
 }
 catch
        {
               #Write error message on screen and to a LOG file
               write-host $_.Exception.Message
               $_.Exception.Message >> "d:\error.log"
        }
        finally
        {
            $ErrorActionPreference = "Stop"
        }
}


#Read more: https://www.sharepointdiary.com/2013/06/how-to-run-sql-server-query-from-powershell.html#ixzz8wrOCO88B

RunSQLQuery "DELETE FROM MASTER_F"
RunSQLQuery "insert into MASTER_F select * from MASTER"
RunSQLQuery "DELETE FROM DETAIL_F"
RunSQLQuery "insert into DETAIL_F select * from DETAIL"

