-- 1. 釣行ログテーブル（環境データ・ボウズ記録に対応）
CREATE TABLE fishing_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    fished_at TIMESTAMPTZ NOT NULL,
    location_name VARCHAR(100) NOT NULL,
    latitude DECIMAL(9, 6),
    longitude DECIMAL(9, 6),
    tide VARCHAR(20),
    tide_level DECIMAL(5, 1),
    water_temp DECIMAL(4, 1),
    wind_direction VARCHAR(20),
    wind_speed DECIMAL(4, 1),
    is_public BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 2. 釣果詳細テーブル（1釣行に対して複数の釣果を紐付け）
CREATE TABLE catch_details (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    log_id UUID NOT NULL REFERENCES fishing_logs(id) ON DELETE CASCADE,
    fish_species VARCHAR(50) NOT NULL,
    size DECIMAL(5, 1),
    bait_lure VARCHAR(100),
    count INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 3. インデックスの作成
CREATE INDEX idx_fishing_logs_user_id ON fishing_logs(user_id);
CREATE INDEX idx_fishing_logs_fished_at ON fishing_logs(fished_at);
CREATE INDEX idx_catch_details_log_id ON catch_details(log_id);
CREATE INDEX idx_catch_details_fish_species ON catch_details(fish_species);