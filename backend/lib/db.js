import mysql2 from 'mysql2/promise';
import config from '@config/config';

const pool = mysql2.createPool(config.db);

export default pool;
