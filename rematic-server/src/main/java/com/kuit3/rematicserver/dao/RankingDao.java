package com.kuit3.rematicserver.dao;

import com.kuit3.rematicserver.dto.home.GetRankedPostDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.List;
import java.util.Map;

@Repository
@Slf4j
public class RankingDao {

    private final NamedParameterJdbcTemplate jdbcTemplate;

    public RankingDao(DataSource dataSource) {
        this.jdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    public int resetRealtimeViewsOnlyToday() {
        String sql = "update Post set realtime_views = :clearing where created_at >= now() - interval 12 hour;";
        Map<String, Object> param = Map.of("clearing", 0);
        return jdbcTemplate.update(sql, param);
    }

    public List<GetRankedPostDto> getRankingByCategory(String category) {
        String sql = "SELECT p.post_id, p.title, p.content, b.name as bulletin, p.likes, p.hates, p.views, p.scraps, p.images as image_url, p.realtime_views " +
                "FROM Post p " +
                "JOIN Bulletin b ON p.bulletin_id = b.bulletin_id " +
                "WHERE p.status = 'active' AND p.created_at >= now() - interval 12 hour " +
                (category != null ? "AND p.category = :category " : "") +
                "ORDER BY p.realtime_views DESC " +
                "LIMIT 10";

        SqlParameterSource params = new MapSqlParameterSource()
                .addValue("category", category);

        log.info("Executing SQL: {}", sql);
        log.info("With parameters: {}", params);

        List<GetRankedPostDto> posts = jdbcTemplate.query(sql, params, (rs, rowNum) ->
                GetRankedPostDto.builder()
                        .rank(rowNum + 1)
                        .post_id(rs.getLong("post_id"))
                        .title(rs.getString("title"))
                        .content(rs.getString("content"))
                        .bulletin(rs.getString("bulletin"))
                        .likes(rs.getLong("likes"))
                        .hates(rs.getLong("hates"))
                        .views(rs.getLong("views"))
                        .scraps(rs.getLong("scraps"))
                        .image_url(rs.getString("image_url"))
                        .build()
        );

        return posts;
    }
}
