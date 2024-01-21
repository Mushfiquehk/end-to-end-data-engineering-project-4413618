from dagster import Definitions, load_assets_from_modules, AssetSelection, ScheduleDefinition, define_asset_job

from .assets import resources

big_star_jobs = define_asset_job("big-star-job", selection=AssetSelection.all())
big_star_schedules = ScheduleDefinition(
    job=big_star_jobs,
    cron_schedule="0 * * * *",
)

defs = Definitions(assets=load_assets_from_modules([assets], resources=resources,
                                                   jobs=[big_star_jobs], schedules=[big_star_schedules]))
