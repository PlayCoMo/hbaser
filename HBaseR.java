import java.io.IOException;
import java.util.Arrays;
import java.util.Set;

import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.client.HBaseAdmin;
import org.apache.hadoop.hbase.HTableDescriptor;
import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.Get;
import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.util.Bytes;

class HBaseR{
	
	HBaseAdmin admin = null;
	HBaseConfiguration config = null;
	
	String[] listTables() throws IOException{
		HTableDescriptor[] tables = this.admin.listTables();
		String[] tableNames = new String[tables.length];
		for(int i = 0; i < tables.length; i++){
			tableNames[i] = tables[i].getNameAsString();
		}
		return tableNames;
	}
	
	void put(String tableName, String row, String family, String column, String value) throws IOException{
		HTable table = new HTable(this.config, tableName);
		Put p = new Put(Bytes.toBytes(row));
		p.add(Bytes.toBytes(family), Bytes.toBytes(column), Bytes.toBytes(value));
		table.put(p);
	}
	
	String getColumnFamily(String tableName, String rowKey, String family) throws IOException{
		HTable table = new HTable(this.config, tableName);
		Get g = new Get(Bytes.toBytes(rowKey));
		g.addFamily(Bytes.toBytes(family));
		
		Result r = table.get(g);
		List<KeyValue> kvList = r.list();
		//String valueStr = Bytes.toString(value);
		//return valueStr;
	}
	
	String get(String tableName, String rowKey, String family, String column) throws IOException{
		HTable table = new HTable(this.config, tableName);
		Get g = new Get(Bytes.toBytes(rowKey));
		Result r = table.get(g);
		byte [] value = r.getValue(Bytes.toBytes(family),
		      Bytes.toBytes(column));
		String valueStr = Bytes.toString(value);
		return valueStr;
	}
	
	public HBaseR() throws IOException{
		this.config = new HBaseConfiguration();
		this.admin = new HBaseAdmin(config);
	}
}

class HBaseRTest {
	
	public static void main(String[] args) throws IOException{
		HBaseR hbr = new HBaseR();
//		hbr.put("tfortable", "test", "fforfamily", "z", "hammertime");
		System.out.println(hbr.getColumnFamily("tfortable", "test", "fforfamily"));
		// System.out.println(Arrays.toString(admin.listTables()));
	}
}
