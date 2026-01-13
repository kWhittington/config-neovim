return {
  {
    'numirias/semshi',
    -- Disabled by default for performance - enable with :Semshi enable if needed
    enabled = false,
    init = function()
      -- If enabled, use performance optimizations
      vim.g['semshi#update_delay_factor'] = 0.001
    end,
  }
}
