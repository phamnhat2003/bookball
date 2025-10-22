import { Breadcrumb, Card, Input, List, Spin } from "antd";
import React, { useEffect, useState } from "react";
import { Link, useHistory } from "react-router-dom";
import "./news.css";
import newsApi from "../../apis/newsApi";

const { Search } = Input;

const News = () => {
  const [news, setNews] = useState([]);
  let history = useHistory();

  useEffect(() => {
    (async () => {
      try {
        await newsApi.getListNews().then((item) => {
          setNews(item);
        });
      } catch (error) {
        console.log("Failed to fetch event detail:" + error);
      }
    })();
    window.scrollTo(0, 0);
  }, []);
  return (
    <div>
      <Spin spinning={false}>
        <Card className="container_details">
          <div className="product_detail">
            <div style={{ marginLeft: 5, marginBottom: 10, marginTop: 10 }}>
              <Breadcrumb>
                <Breadcrumb.Item href="http://localhost:3500/home">
                  {/* <HomeOutlined /> */}
                  <span style={{fontSize: "15px" }}>Trang chủ</span>
                </Breadcrumb.Item>
                <Breadcrumb.Item href="http://localhost:3500/news">
                  {/* <AuditOutlined /> */}
                  <span style={{fontSize: "15px" }}>Sự kiện</span>
                </Breadcrumb.Item>
              </Breadcrumb>
            </div>
            <hr></hr>
            <div class="news">
              <List
  grid={{
    gutter: 24,
    xs: 1,
    sm: 2,
    md: 3,
    lg: 4,
    xl: 4,
    xxl: 4
  }}
  dataSource={news}
  renderItem={(item) => (
    <List.Item>
      <Link to={`/news/${item.id}`} className="news-card-link">
        <Card
          hoverable
          className="news-card"
          cover={
            <div className="news-image-container">
              <img
                alt={item.name}
                src={item.image}
                className="news-image"
              />
            </div>
          }
        >
          <div className="news-content">
            <h4 className="news-title" title={item.name}>
              {item.name}
            </h4>
            {item.description && (
              <div className="news-description">
                {item.description.replace(/<[^>]*>?/gm, '')}
              </div>
            )}
          </div>
        </Card>
      </Link>
    </List.Item>
  )}
/>
            </div>
          </div>
        </Card>
      </Spin>
    </div>
  );
};

export default News;
