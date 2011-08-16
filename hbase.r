setwd('~/Projects/HBaseR')
.onLoad <- function(){
    require(rJava)
    Sys.unsetenv("CLASSPATH")
    .jinit()
	
    for(i in list.files('/Users/jspies/Projects/HBaseR/hbase-0.20.6/lib', full.names=T)){
        .jaddClassPath(i)
    }

	.jaddClassPath('/Users/jspies/Projects/HBaseR/')
}

HBaseR_get <- function(table, key, family, column){
	.jcall(hbaser, "S", "get", table, key, family, column)
}

HBaseR_put <- function(table, key, family, column, value){
	.jcall(hbaser, "V", "put", table, key, family, column, value)
	return
}

.onLoad()

hbaser <- .jnew("HBaseR")
tableNames <- .jcall(hbaser, "[S", "listTables")



HBaseR_get("tfortable", "rforrow", "fforfamily", "x")











setwd('~/Projects/HBaseR')
.onLoad <- function(){
    require(rJava)
    Sys.unsetenv("CLASSPATH")
    .jinit()

    .jaddClassPath('/Users/jspies/Downloads/hbase-0.20.6/conf/')
    Sys.setenv(CLASSPATH="/Users/jspies/Downloads/hbase-0.20.6/conf/")
    
    for(i in list.files('/Users/jspies/Projects/HBaseR/hbase-0.20.6/lib', full.names=T)){
        .jaddClassPath(i)
    }
}

toBytes <- function(x){
    .jcall("org/apache/hadoop/hbase/util/Bytes", "[B", "toBytes", x)
}

HBaseAdmin_createTable <- function(tableName){
    mytable <- .jnew("org.apache.hadoop.hbase.HTableDescriptor", tableName)
    .jcall(hbAdmin, "V", "createTable", mytable)
}

addFamily <- function(tableName, columnName){
	mytable <- .jnew("org.apache.hadoop.hbase.HTableDescriptor", toBytes(tableName))
	myfamily <- .jnew("org.apache.hadoop.hbase.HColumnDescriptor", toBytes(columnName))
	.jcall(mytable, "V", "addFamily", myfamily)
}

getFamilies <- function(tableName){
	mytable <- .jnew("org.apache.hadoop.hbase.HTableDescriptor", tableName)
	.jcall(mytable, "Ljava/util/Collection;", "getFamilies")
}

HBaseAdmin_listTables <- function(){
	.jcall(hbAdmin, '[org/apache/hadoop/hbase/HTableDescriptor', 'listTables')
}

HBaseAdmin_getTableDescriptor <- function(tableName){
	.jcall(hbAdmin, 'Lorg/apache/hadoop/hbase/HTableDescriptor;', 'getTableDescriptor', toBytes(tableName))
}

.onLoad()

hbConfig <- .jnew("org/apache/hadoop/hbase/HBaseConfiguration")
hbAdmin <- .jnew("org/apache/hadoop/hbase/client/HBaseAdmin", hbConfig)

HBaseAdmin_listTables()

HBaseAdmin_createTable("myLittleHBaseTable")
addFamily("myLittleHBaseTable", "myFamily:")

p <- .jnew("org/apache/hadoop/hbase/client/Put", toBytes("myLittleRow"))
myStack <- .jnew("java/util/Stack")
myStack <- .jcall(myStack, "Ljava/util/Stack;", "push", p)
.jcall(mytable, "V", "put", myStack)


