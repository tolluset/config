return {
  {
    "3rd/image.nvim",
    opts = {
      backend = "kitty", -- kitty가 더 성능이 좋아요
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki" }, -- 마크다운 관련 파일타입 추가
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = nil,
      window_overlap_clear_enabled = false, -- 창 겹칠 때 이미지 자동으로 지우기
      editor_only_render_when_focused = false, -- 에디터에 포커스 있을때만 렌더링
      tmux_show_only_in_active_window = false, -- tmux 쓰시면 활성화된 창에서만 보여주기
      processor = "magick_cli", -- CLI 프로세서 사용
    },
  },
}
