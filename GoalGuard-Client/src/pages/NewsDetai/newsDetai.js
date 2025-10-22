import { Breadcrumb, Row, List, Card, Spin } from "antd";
import React, { useEffect, useState } from "react";
import { Link, useHistory, useParams } from "react-router-dom";
import Paragraph from "antd/lib/typography/Paragraph";
import newsApi from "../../apis/newsApi";
import "./newsDetai.css";

// const { Search } = Input;

const NewsDetai = () => {
  const [news, setNews] = useState([]);
  const [relatedNews, setRelatedNews] = useState([]);
  let history = useHistory();
  const { id } = useParams();
  const { Meta } = Card;

  useEffect(() => {
  (async () => {
    try {
      // Lấy chi tiết tin tức hiện tại
      const item = await newsApi.getDetailNews(id);
      setNews(item);

      // Lấy danh sách tất cả tin tức
      const list = await newsApi.getListNews();

      // Lọc bỏ tin hiện tại và lấy tối đa 6 tin khác
      const related = list.filter(newsItem => newsItem.id !== id).slice(0, 6);
      setRelatedNews(related);  // bạn cần khai báo state relatedNews

    } catch (error) {
      console.log("Failed to fetch news detail or related news: " + error);
    }
  })();
  window.scrollTo(0, 0);
}, [id]);

  return (
    <div>
      <Spin spinning={false}>
        <Card className="container_details">
          <div className="product_detail">
            <div style={{ marginLeft: 5, marginBottom: 10, marginTop: 10 }}>
              <Breadcrumb>
                <Breadcrumb.Item href="http://localhost:3500/home">
                  <span style={{fontSize: "15px" }}>Trang chủ</span>
                </Breadcrumb.Item>
                <Breadcrumb.Item href="http://localhost:3500/news">
                  <span style={{fontSize: "15px" }}>Tin tức</span>
                </Breadcrumb.Item>
                <Breadcrumb.Item href="">
                  <span style={{fontSize: "15px" }}>{news.name}</span>
                </Breadcrumb.Item>
              </Breadcrumb>
            </div>
            <hr></hr>
            <div class="pt-5-container">
              <img src={news?.image} alt="Tournament Image" className="w-full my-4" />
              <div class="newsdetaititle">{news.name}</div>
              <div dangerouslySetInnerHTML={{ __html: news.description }}></div>
              <div className="news-related-section" style={{ marginTop: 40 }}>
              <div className="news-related-section" style={{ marginTop: 40 }}>
  <h3 class="newsdetaititle">Tin tức bạn có thể quan tâm</h3>
  <List
    grid={{
      gutter: 24,
      xs: 1,
      sm: 2,
      md: 3,
      lg: 4,
      xl: 4,
      xxl: 4,
    }}
    dataSource={relatedNews}
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
                  src={item.image || "/default-news-image.jpg"}
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
                  {item.description.replace(/<[^>]*>?/gm, '').slice(0, 150)}{/* cắt mô tả ngắn */}
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
            </div>
          </div>
        </Card>
      </Spin>
    </div>
  );
};

export default NewsDetai;
