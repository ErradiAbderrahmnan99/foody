<template>
    <section class="col-12 item-show-page">
        <LoadingComponent :props="loading" />

        <div class="item-hero">
            <div>
                <p class="eyebrow">{{ $t('label.information') }}</p>
                <h2 class="hero-title">{{ item.name }}</h2>
                <p class="hero-subtitle">{{ item.category_name }}</p>
            </div>

            <div class="hero-price">
                <span>{{ $t('label.price') }}</span>
                <strong>{{ item.flat_price }}</strong>
            </div>
        </div>

        <div class="item-tabs">
            <button
                type="button"
                @click="handleTab($event, '#information', '.db-tabBtn', '.db-tabDiv', 'active')"
                class="db-tabBtn item-tab active"
            >
                <i class="lab lab-information lab-font-size-16"></i>
                {{ $t('label.information') }}
            </button>

            <button
                type="button"
                @click="handleTab($event, '#image', '.db-tabBtn', '.db-tabDiv', 'active')"
                class="db-tabBtn item-tab"
            >
                <i class="lab lab-image lab-font-size-16"></i>
                {{ $t('label.images') }}
            </button>

            <button
                type="button"
                class="db-tabBtn item-tab"
                @click="handleTab($event, '#variations', '.db-tabBtn', '.db-tabDiv', 'active')"
            >
                <i class="lab lab-variation lab-font-size-16"></i>
                {{ $t('label.variation') }}
            </button>

            <button
                type="button"
                class="db-tabBtn item-tab"
                @click="handleTab($event, '#extra', '.db-tabBtn', '.db-tabDiv', 'active')"
            >
                <i class="lab lab-extra lab-font-size-16"></i>
                {{ $t('label.extra') }}
            </button>

            <button
                type="button"
                class="db-tabBtn item-tab"
                @click="handleTab($event, '#addon', '.db-tabBtn', '.db-tabDiv', 'active')"
            >
                <i class="lab lab-addon lab-font-size-16"></i>
                {{ $t('label.addon') }}
            </button>
        </div>

        <div class="item-card">
            <div class="db-tabDiv active" id="information">
                <div class="info-grid">
                    <div class="info-box">
                        <span>{{ $t('label.name') }}</span>
                        <strong>{{ item.name }}</strong>
                    </div>

                    <div class="info-box">
                        <span>{{ $t('label.price') }}</span>
                        <strong>{{ item.flat_price }}</strong>
                    </div>

                    <div class="info-box">
                        <span>{{ $t('label.category') }}</span>
                        <strong>{{ item.category_name }}</strong>
                    </div>

                    <div class="info-box">
                        <span>{{ $t('label.tax') }}</span>
                        <strong>{{ tax_name }}</strong>
                    </div>

                    <div class="info-box">
                        <span>{{ $t('label.type') }}</span>
                        <strong>{{ enums.itemTypeEnumArray[item.item_type] }}</strong>
                    </div>

                    <div class="info-box">
                        <span>{{ $t('label.featured') }}</span>
                        <strong>{{ enums.askEnumArray[item.is_featured] }}</strong>
                    </div>

                    <div class="info-box">
                        <span>{{ $t('label.status') }}</span>
                        <strong>{{ enums.statusEnumArray[item.status] }}</strong>
                    </div>
                </div>

                <div class="content-box">
                    <h4>{{ $t('label.caution') }}</h4>
                    <p>{{ item.caution }}</p>
                </div>

                <div class="content-box">
                    <h4>{{ $t('label.description') }}</h4>
                    <p>{{ item.description }}</p>
                </div>
            </div>

            <div class="db-tabDiv" id="image">
                <div class="image-layout">
                    <div class="image-preview-card">
                        <img class="item-preview-image" alt="slider" :src="previewImage" />
                    </div>

                    <form @submit.prevent="saveImage" class="image-form-card">
                        <p class="image-size">{{ $t('label.size') }}: (262px,182px)</p>

                        <div class="image-actions">
                            <label
                                for="photo"
                                class="image-btn upload-btn"
                            >
                                <i class="lab lab-upload-image"></i>
                                <span>{{ $t("button.upload_new_image") }}</span>

                                <input
                                    v-if="uploadButton"
                                    @change="changePreviewImage"
                                    ref="imageProperty"
                                    accept="image/png, image/jpeg, image/jpg"
                                    type="file"
                                    id="photo"
                                    class="file-input"
                                />
                            </label>

                            <button
                                v-if="saveButton"
                                type="submit"
                                class="image-btn save-btn"
                            >
                                <i class="lab lab-tick-circle-2"></i>
                                <span>{{ $t("button.save") }}</span>
                            </button>

                            <button
                                v-if="resetButton"
                                @click="resetPreviewImage"
                                type="button"
                                class="image-btn reset-btn"
                            >
                                <i class="lab lab-reset"></i>
                                <span>{{ $t("button.reset") }}</span>
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="db-tabDiv" id="variations">
                <ItemVariationListComponent :item="parseInt($route.params.id)" />
            </div>

            <div class="db-tabDiv" id="extra">
                <ItemExtraListComponent :item="parseInt($route.params.id)" />
            </div>

            <div class="db-tabDiv" id="addon">
                <ItemAddonListComponent :item="parseInt($route.params.id)" />
            </div>
        </div>
    </section>
</template>

<script>
import LoadingComponent from "../components/LoadingComponent";
import statusEnum from "../../../enums/modules/statusEnum";
import itemTypeEnum from "../../../enums/modules/itemTypeEnum";
import askEnum from "../../../enums/modules/askEnum";
import appService from "../../../services/appService";
import alertService from "../../../services/alertService";
import ItemVariationListComponent from "./variation/ItemVariationListComponent";
import ItemExtraListComponent from "./extra/ItemExtraListComponent";
import ItemAddonListComponent from "./addon/ItemAddonListComponent";

export default {
    name: "ItemCategoryShowComponent",
    components: {
        ItemVariationListComponent,
        LoadingComponent,
        ItemExtraListComponent,
        ItemAddonListComponent
    },
    data() {
        return {
            loading: {
                isActive: false
            },
            enums: {
                statusEnum: statusEnum,
                itemTypeEnum: itemTypeEnum,
                askEnum: askEnum,
                statusEnumArray: {
                    [statusEnum.ACTIVE]: this.$t("label.active"),
                    [statusEnum.INACTIVE]: this.$t("label.inactive")
                },
                itemTypeEnumArray: {
                    [itemTypeEnum.VEG]: this.$t("label.veg"),
                    [itemTypeEnum.NON_VEG]: this.$t("label.non_veg")
                },
                askEnumArray: {
                    [askEnum.YES]: this.$t("label.yes"),
                    [askEnum.NO]: this.$t("label.no")
                }
            },
            tax_name: "",
            defaultImage: null,
            previewImage: null,
            uploadButton: true,
            resetButton: false,
            saveButton: false,
        }
    },
    computed: {
        item: function () {
            return this.$store.getters['item/show'];
        }
    },
    mounted() {
        this.loading.isActive = true;
        this.$store.dispatch('item/show', this.$route.params.id).then(res => {
            this.defaultImage = res.data.data.preview;
            this.previewImage = res.data.data.preview;
            this.loading.isActive = false;
        }).catch((error) => {
            this.loading.isActive = false;
        });
    },
    methods: {
        statusClass: function (status) {
            return appService.statusClass(status);
        },
        handleTab: function (event, targetID, targetButton, targetDiv, activeClass) {
            return appService.handleTab(event, targetID, targetButton, targetDiv, activeClass);
        },
        changePreviewImage: function (e) {
            if (e.target.files[0]) {
                this.previewImage = URL.createObjectURL(e.target.files[0]);
                this.saveButton = true;
                this.resetButton = true;
            }
        },
        resetPreviewImage: function () {
            this.$refs.imageProperty.value = null;
            this.previewImage = this.defaultImage;
            this.saveButton = false;
            this.resetButton = false;
        },
        saveImage: function () {
            if (this.$refs.imageProperty.files[0]) {
                try {
                    this.loading.isActive = true;
                    const formData = new FormData();
                    formData.append("image", this.$refs.imageProperty.files[0]);
                    this.$store
                        .dispatch("item/changeImage", {
                            id: this.$route.params.id,
                            form: formData,
                        })
                        .then((res) => {
                            alertService.success(this.$t("message.image_update"));
                            this.defaultImage = res.data.data.preview;
                            this.previewImage = res.data.data.preview;
                            this.$refs.imageProperty.value = null;
                            this.saveButton = false;
                            this.resetButton = false;
                            this.loading.isActive = false;
                        })
                        .catch((err) => {
                            this.loading.isActive = false;
                            this.imageErrors = err.response.data.errors;
                            alertService.error(err.response.data.message);
                        });
                } catch (err) {
                    this.loading.isActive = false;
                    alertService.error(err.response.data.message);
                }
            }
        },
    },
    watch: {
        item: {
            deep: true,
            handler(item) {
                if (typeof item.tax === 'object' && item.tax != null) {
                    if (typeof item.tax.name !== "undefined") {
                        this.tax_name = item.tax.name;
                    }
                }

                if (typeof item.category.name !== "undefined") {
                    this.item.category_name = item.category.name;
                }
            }
        }
    }
}
</script>

<style scoped>
.item-show-page {
    position: relative;
    padding: 22px;
    border-radius: 28px;
    background:
        radial-gradient(circle at top left, rgba(26, 183, 89, 0.16), transparent 34%),
        linear-gradient(135deg, #f8fff9 0%, #ffffff 44%, #f4f7fb 100%);
    border: 1px solid rgba(15, 23, 42, 0.08);
    box-shadow: 0 24px 70px rgba(15, 23, 42, 0.08);
}

.item-hero {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 18px;
    padding: 22px;
    margin-bottom: 18px;
    border-radius: 24px;
    background: linear-gradient(135deg, #101828, #1f3d2b);
    color: #ffffff;
    overflow: hidden;
}

.eyebrow {
    margin: 0 0 6px;
    font-size: 12px;
    letter-spacing: 0.14em;
    text-transform: uppercase;
    color: rgba(255, 255, 255, 0.66);
}

.hero-title {
    margin: 0;
    font-size: 26px;
    font-weight: 800;
    line-height: 1.2;
    color: #ffffff;
}

.hero-subtitle {
    margin: 8px 0 0;
    color: rgba(255, 255, 255, 0.72);
}

.hero-price {
    min-width: 150px;
    padding: 16px 18px;
    border-radius: 20px;
    background: rgba(255, 255, 255, 0.12);
    border: 1px solid rgba(255, 255, 255, 0.16);
    text-align: right;
}

.hero-price span {
    display: block;
    font-size: 12px;
    color: rgba(255, 255, 255, 0.62);
}

.hero-price strong {
    display: block;
    margin-top: 4px;
    font-size: 22px;
    color: #ffffff;
}

.item-tabs {
    display: grid;
    grid-template-columns: repeat(5, minmax(0, 1fr));
    gap: 10px;
    margin-bottom: 18px;
}

.item-tab {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 9px;
    min-height: 48px;
    padding: 12px 14px;
    border-radius: 16px;
    background: #ffffff;
    color: #64748b;
    border: 1px solid rgba(15, 23, 42, 0.08);
    font-weight: 700;
    transition: all 0.2s ease;
}

.item-tab:hover {
    color: #1ab759;
    border-color: rgba(26, 183, 89, 0.3);
    transform: translateY(-1px);
}

.item-tab.active {
    color: #ffffff;
    background: linear-gradient(135deg, #1ab759, #119447);
    border-color: transparent;
    box-shadow: 0 14px 30px rgba(26, 183, 89, 0.26);
}

.item-card {
    padding: 22px;
    border-radius: 24px;
    background: rgba(255, 255, 255, 0.88);
    border: 1px solid rgba(15, 23, 42, 0.08);
}

.db-tabDiv {
    display: none;
}

.db-tabDiv.active {
    display: block;
}

.info-grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 14px;
}

.info-box {
    padding: 16px;
    border-radius: 18px;
    background: #f8fafc;
    border: 1px solid rgba(15, 23, 42, 0.06);
}

.info-box span {
    display: block;
    margin-bottom: 8px;
    font-size: 12px;
    font-weight: 700;
    color: #94a3b8;
    text-transform: uppercase;
    letter-spacing: 0.06em;
}

.info-box strong {
    display: block;
    color: #0f172a;
    font-size: 15px;
    font-weight: 800;
    word-break: break-word;
}

.content-box {
    margin-top: 16px;
    padding: 18px;
    border-radius: 20px;
    background: #ffffff;
    border: 1px solid rgba(15, 23, 42, 0.08);
}

.content-box h4 {
    margin: 0 0 10px;
    color: #0f172a;
    font-size: 15px;
    font-weight: 800;
}

.content-box p {
    margin: 0;
    color: #64748b;
    line-height: 1.7;
}

.image-layout {
    display: grid;
    grid-template-columns: minmax(260px, 420px) 1fr;
    gap: 22px;
    align-items: start;
}

.image-preview-card {
    padding: 16px;
    border-radius: 24px;
    background:
        linear-gradient(135deg, rgba(26, 183, 89, 0.12), rgba(15, 23, 42, 0.04)),
        #ffffff;
    border: 1px solid rgba(15, 23, 42, 0.08);
}

.item-preview-image {
    width: 100%;
    min-height: 240px;
    object-fit: cover;
    border-radius: 18px;
    background: #f1f5f9;
}

.image-form-card {
    padding: 22px;
    border-radius: 24px;
    background: #f8fafc;
    border: 1px dashed rgba(26, 183, 89, 0.32);
}

.image-size {
    margin: 0 0 18px;
    color: #64748b;
    font-weight: 700;
}

.image-actions {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
}

.image-btn {
    position: relative;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    min-height: 42px;
    padding: 0 18px;
    border-radius: 999px;
    font-weight: 800;
    cursor: pointer;
    transition: all 0.2s ease;
}

.upload-btn,
.save-btn {
    color: #ffffff;
    background: #1ab759;
    box-shadow: 0 12px 22px rgba(26, 183, 89, 0.24);
}

.reset-btn {
    color: #fb4e4e;
    background: #ffffff;
    border: 1px solid rgba(251, 78, 78, 0.35);
    box-shadow: 0 12px 22px rgba(251, 78, 78, 0.12);
}

.image-btn:hover {
    transform: translateY(-1px);
}

.file-input {
    position: absolute;
    inset: 0;
    width: 100%;
    height: 100%;
    opacity: 0;
    cursor: pointer;
}

@media (max-width: 768px) {
    .item-show-page {
        padding: 14px;
        border-radius: 22px;
    }

    .item-hero {
        flex-direction: column;
        align-items: flex-start;
    }

    .hero-price {
        width: 100%;
        text-align: left;
    }

    .item-tabs {
        grid-template-columns: 1fr;
    }

    .info-grid,
    .image-layout {
        grid-template-columns: 1fr;
    }

    .item-card {
        padding: 14px;
    }
}
</style>