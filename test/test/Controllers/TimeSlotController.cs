using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using test.Models;

namespace test.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TimeSlotController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        public TimeSlotController(IConfiguration configuration)
        {
            _configuration = configuration;
        }
        [HttpGet]
        public JsonResult Get()
        {
            DataTable dt = new DataTable();
            SqlDataReader sqlDataReader;
            using (SqlConnection myCon = new SqlConnection(_configuration.GetConnectionString("StudentConn")))
            {
                myCon.Open();
                using (SqlCommand sc = new SqlCommand("s_getTimeSlots", myCon))
                {
                    sc.CommandType = CommandType.StoredProcedure;
                    sqlDataReader = sc.ExecuteReader();
                    dt.Load(sqlDataReader);
                    sqlDataReader.Close();
                    myCon.Close();
                }
            }
            return new JsonResult(dt);
        }
        [HttpPost]
        public JsonResult Post(TimeSlot ts)
        {
            DataTable dt = new DataTable();
            SqlDataReader sqlDataReader;
            using (SqlConnection myCon = new SqlConnection(_configuration.GetConnectionString("StudentConn")))
            {
                myCon.Open();
                using (SqlCommand sc = new SqlCommand("t_save", myCon))
                {
                    sc.CommandType = CommandType.StoredProcedure;
                    sc.Parameters.AddWithValue("@TSCode", ts.TSCode);
                    sc.Parameters.AddWithValue("@StartTime", ts.StartTime);
                    sc.Parameters.AddWithValue("@EndTime", ts.EndTime);
                    sc.Parameters.AddWithValue("@RId", ts.RId);
                    sqlDataReader = sc.ExecuteReader();
                    dt.Load(sqlDataReader);
                    sqlDataReader.Close();
                    myCon.Close();
                }
            }
            return new JsonResult(dt);
        }
        [HttpPut]
        public JsonResult Put(TimeSlot ts)
        {
            DataTable dt = new DataTable();
            SqlDataReader sqlDataReader;
            using (SqlConnection myCon = new SqlConnection(_configuration.GetConnectionString("StudentConn")))
            {
                myCon.Open();
                using (SqlCommand sc = new SqlCommand("t_update", myCon))
                {
                    sc.CommandType = CommandType.StoredProcedure;
                    sc.Parameters.AddWithValue("@TSId", ts.TSId);
                    sc.Parameters.AddWithValue("@TSCode", ts.TSCode);
                    sc.Parameters.AddWithValue("@StartTime", ts.StartTime);
                    sc.Parameters.AddWithValue("@EndTime", ts.EndTime);
                    sc.Parameters.AddWithValue("@RId", ts.RId);
                    sqlDataReader = sc.ExecuteReader();
                    dt.Load(sqlDataReader);
                    sqlDataReader.Close();
                    myCon.Close();
                }
            }
            return new JsonResult(dt);


        }
        [HttpDelete]
        public JsonResult Delete(TimeSlot ts)
        {
            DataTable dt = new DataTable();
            SqlDataReader sqlDataReader;
            using (SqlConnection myCon = new SqlConnection(_configuration.GetConnectionString("StudentConn")))
            {
                myCon.Open();
                using (SqlCommand sc = new SqlCommand("t_delTimeSlot", myCon))
                {
                    sc.CommandType = CommandType.StoredProcedure;
                    sc.Parameters.AddWithValue("@TSId", ts.TSId);
                    sqlDataReader = sc.ExecuteReader();
                    dt.Load(sqlDataReader);
                    sqlDataReader.Close();
                    myCon.Close();
                }
            }
            return new JsonResult(dt);
        }
    }
}
