package org.ldbcouncil.snb.impls.workloads.apacheage;

import org.apache.age.jdbc.base.Agtype;
import org.ldbcouncil.snb.driver.DbException;
import org.ldbcouncil.snb.impls.workloads.BaseDbConnectionState;
import org.ldbcouncil.snb.impls.workloads.QueryStore;
import org.postgresql.jdbc.PgConnection;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;
import java.util.Properties;
import java.util.TimeZone;

public class PostgresDbConnectionState<TDbQueryStore extends QueryStore> extends BaseDbConnectionState<TDbQueryStore> {

    protected String endPoint;
    protected HikariDataSource ds;

    public PostgresDbConnectionState(Map<String, String> properties, TDbQueryStore store) throws ClassNotFoundException {
        super(properties, store);
        endPoint = properties.get("endpoint");

        Class.forName(properties.get("jdbcDriver"));

        Properties props = new Properties();
        endPoint = properties.get("endpoint");
        props.setProperty("jdbcUrl", endPoint);
        props.setProperty("dataSource.databaseName", properties.get("databaseName"));
        props.setProperty("dataSource.assumeMinServerVersion", "9.0");
        props.setProperty("dataSource.ssl", "false");
        HikariConfig config = new HikariConfig(props);
        config.setPassword(properties.get("password"));
        config.setUsername(properties.get("user"));
        config.setJdbcUrl(endPoint);
        ds = new HikariDataSource(config);
    }

    public Connection getConnection() throws DbException {
        Connection connection = null;
        try {
            TimeZone.setDefault(TimeZone.getTimeZone("Etc/GMT+0"));
            connection = ds.getConnection();
            
            PgConnection pgConn = connection.unwrap(PgConnection.class);
            
            pgConn.addDataType("agtype", Agtype.class);

    		// configure AGE
    		Statement statement = connection.createStatement();
    		statement.execute("CREATE EXTENSION IF NOT EXISTS age;");
    		statement.execute("LOAD 'age'");
    		statement.execute("SET search_path = ag_catalog, \"$user\", public;");
            
        } catch (SQLException e) {
            throw new DbException(e);
        }
        return connection;
    }

    @Override
    public void close() {
        if (ds != null) {
            ds.close();
        }
    }
}